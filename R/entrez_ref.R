
# load packages/functions, run this  ------------------------------------------------

library(rentrez)
library(yingtools2)
library(tidyverse)
library(XML)
library(rlang)

# use to preview an xml
preview_xml_parts <- function(xml) {
  if (!is.list(xml)) {
    if (isXMLString(xml)) {
      xml <- xml %>% xmlToList(simplify=FALSE)
    } else {
      cli::cli_abort("YTError: need xml or list")
    }  
  }
  xml %>% traverse(expr={
    child.names <- names(.obj) %||% rep(NA_character_,length(.obj))
    duplicated.child.names <- unique(child.names[duplicated(child.names)])
    tag.values <- map(duplicated.child.names,function(child.name) {
      in.dup.name <- child.names==child.name
      grandchildren <- .obj[in.dup.name] %>% map(~{
        map_chr(.x,class)
      })
      all.character <- grandchildren %>% map_lgl(~all(.x=="character")) %>% all()
      tags <- grandchildren %>% map(names) %>% reduce(intersect)
      if (all.character && length(tags)>0) {
        cli::cli_alert("Tag-values found in: {.pkg {(.code)}}")
        cli::cli_alert("name={.pkg {child.name}}, tags={cli::col_yellow(tags)} (x{sum(in.dup.name)} values)")
      }
      list(code=.code,
           name=child.name,
           tags=tags)
    })
    # tag.values
    if (is.list(.obj)) {
      NULL
    } else {
      tibble(level=.level,class=.class,code=.code,val=deparse(.obj),pluck=list(.pluck))  
    }  
  }) %>% list_rbind()
}

hoist_tag_values <- function(.data,.col, ...) {
  .col <- enquo(.col)
  dots <- list(...)
  newdots <- dots %>% map(~.x[-length(.x)])
  lastvars <- dots %>% map_chr(~.x[[length(.x)]]) %>% unname()
  varnames <- names(dots)
  newdata <- rlang::inject(hoist(.data=.data,.col=!!.col,!!!newdots))
  for (i in seq_along(varnames)) {
    varname <- varnames[i]
    lastvar <- lastvars[i]
    # only keep lastvar values
    newdata[[varname]] <- map(newdata[[varname]],~{
      tag.values <- .x[names(.x)==lastvar]
      tag.frame <- tag.values %>% map(bind_rows) %>% list_rbind()
      # df.row <- setNames(tag.frame$VALUE,tag.frame$TAG) %>% bind_rows()
      return(tag.frame)
    })
  }
  newdata
}



# try to flatten all elements
unnest_xml_row <- function(xml) {
  df_row <- xml %>% traverse(expr={
    pluckname <- paste(.pluck,collapse="..")
    # cli::cli_alert("{pluckname}")
    if (is.list(.obj)) {
      # objnames <- names(.obj) %||% rep(NA_character_,length(.obj))
      # objnames <- if_else(have_name(.obj),names(.obj),NA_character_)
      objnames <- name_along(.obj)
      dupnames <- objnames[duplicated(objnames)] %>% unique()
      # duplicated names will be saved as listcols
      if (length(dupnames)>0) {
        pluck.dupnames <- paste(pluckname,dupnames,sep="..")
        dupcols.tbl <- map2(dupnames,pluck.dupnames,~{
          sublist <- list(.obj[names(.obj)==.x])
          tibble(sublist) %>% setNames(.y)
        }) %>% list_cbind()
        # # remove dupnames from .obj, it'll continue if anything is left
        .obj <- .obj[!(names(.obj) %in% dupnames)]
        dupcols.tbl
      } else {
        # continue processing children, no row here.
        NULL
      }
    } else if (is.character(.obj)) {
      if (!is_named(.obj) && length(.obj)==1) {
        .obj %>% setNames(pluckname) %>% bind_rows()
      } else {
        # pluckname <- paste0(pluckname,"..multi_named_vector")
        tibble(var=list(.obj)) %>% setNames(pluckname)
      }
    } else if (is.null(.obj)) {
      # empty obj, return NA
      setNames(NA_character_,pluckname) %>% bind_rows()
    } else {
      cli::cli_abort("YTError: obj not recognized in pluckname={pluckname}")
    }
  }) %>% purrr::compact() %>% list_cbind()
  return(df_row)
}
# converts a list of xmllists to df rows
unnest_xml <- function(data,xmlcol) {
  xmlcol <- enquo(xmlcol)
  data2 <- data %>%
    mutate(.row=map(!!xmlcol,unnest_xml_row))

  # check types before joining
  coltypes <- data2$.row %>%
    imap(function(r,i) {
      tibble(i=i,col=names(r),value=as.list(r)) %>% mutate(class=map_chr(value,~class(.x)[1]))
    }) %>% list_rbind()
  colsum <- coltypes %>%
    group_by(col) %>%
    summarize(n=n(),
              multiclass=n_distinct(class)>1,
              classes=paste(unique(class),collapse=","),
              nlist=sum(class=="list"),
              nchar=sum(class=="character"),
              chars=paste(i[class=="character"],collapse=","),
              lists=paste(i[class=="list"],collapse=","),
              .groups="drop") %>%
    mutate(orphan=n<=3)
  multiclass <- colsum %>% filter(multiclass)
  orphan <- colsum %>% filter(orphan)
  multicols <- multiclass$col
  # change these to lists
  data3 <- data2 %>% mutate(.row=map(.row,function(r) {
    r %>% mutate(across(.cols=any_of(multicols),.fns=as.list))
  }))
  
  if (nrow(multiclass)>0) {
    cli::cli_alert("These were converted to lists: {.pkg {multiclass$col}}")
  }
  if (nrow(orphan)>0) {
    cli::cli_alert("These were rare cols: {.pkg {orphan$col}}")
  }
  data3 %>% unnest(.row, names_repair="unique")
}



# db info -----------------------------------------------------------------

# set API key (edit .Renviron)
set_entrez_key("3fe58c23fa355f854ae8378eb3dcef9e7909")
Sys.getenv("ENTREZ_KEY")

# all entrez DBs
# pubmed, protein, nuccore=nucleotide, ipg, structure, genome, annotinfo, assembly, bioproject, 
# biosample, blastdbinfo, books, cdd, clinvar, gap, gapplus, grasp, dbvar, gene, gds, geoprofiles, 
# medgen, mesh, nlmcatalog, omim, orgtrack, pmc, proteinclusters, pcassay, protfam, pccompound, 
# pcsubstance, seqannot, snp, sra, taxonomy, biocollections, gtr
entrez_dbs()
entrez_db_summary("pubmed")
entrez_db_summary("protein")
entrez_db_summary("cdd")
entrez_db_summary("gap")
entrez_db_summary("nucleotide")

# [1] "annotinfo: Annotinfo Database (2.53K)"                      "assembly: Genome Assembly Database (3.54M)"                
# [3] "biocollections: Biocollections db (8.5K)"                   "bioproject: BioProject Database (1.04M)"                   
# [5] "biosample: BioSample Database (53.8M)"                      "blastdbinfo: BlastdbInfo Database (3.44M)"                 
# [7] "books: Books Database (1.32M)"                              "cdd: Conserved Domain Database (67.2K)"                    
# [9] "clinvar: ClinVar Database (4.49M)"                          "dbvar: dbVar records (8.67M)"                              
# [11] "gap: dbGaP Data (364K)"                                     "gapplus: Internal Genotypes and Phenotypes database (137K)"
# [13] "gds: GEO DataSets (8.76M)"                                  "gene: Gene database (94.4M)"                               
# [15] "genome: Genomic sequences, contigs, and maps (88.3K)"       "geoprofiles: Genes Expression Omnibus (128M)"              
# [17] "grasp: grasp Data (7.86M)"                                  "gtr: GTR Database (64.4K)"                                 
# [19] "ipg: Identical Protein Groups DB (1.08B)"                   "medgen: Medgen Database (234K)"                            
# [21] "mesh: MeSH Database (356K)"                                 "nlmcatalog: NLM Catalog Database (1.66M)"                  
# [23] "nuccore/nucleotide: Core Nucleotide db (713M)"              "omim: OMIM records (29.5K)"                                
# [25] "orgtrack: Orgtrack Database (9.2K)"                         "pcassay: PubChem BioAssay Database (1.77M)"                
# [27] "pccompound: PubChem Compound Database (124M)"               "pcsubstance: PubChem Substance Database (347M)"            
# [29] "pmc: PubMed Central (12.1M)"                                "protein: Protein sequence record (1.58B)"                  
# [31] "proteinclusters: Protein Cluster record (1.14M)"            "protfam: protfam DB (178K)"                                
# [33] "pubmed: PubMed bibliographic record (40.4M)"                "seqannot: SeqAnnot Database (515K)"                        
# [35] "snp: Single Nucleotide Polymorphisms (1.2B)"                "sra: SRA Database (43.7M)"                                 
# [37] "structure: Three-dimensional molecular model (252K)"        "taxonomy: Taxonomy db (2.87M)"    


# helps provide search fields, somehow
all_the_data <- entrez_info()
all_the_data_list <- XML::xmlToList(all_the_data)
XML::xpathSApply(all_the_data, "//DbName", xmlValue)


# databases that are cross-referenced links in the given database
entrez_db_links("pubmed")
entrez_db_links("biosample")
entrez_db_links("nuccore")
entrez_db_links("sra")
entrez_db_links("taxonomy")

# all links
alllinks <- tibble(db=entrez_dbs()) %>% 
  mutate(links=map(db,entrez_db_links),
         ref_by=map(links,names))

# get searchable terms
entrez_db_searchable("sra")
entrez_db_searchable("nucleotide")

# searching -----------------------------------------------------------


# pubmed search
# entrez_db_searchable("pubmed") to see terms
yt_search <- entrez_search(db="pubmed", term="ying taur[FULL]",retmax=40)
yt_search$ids
yt_search$count

# sra search
# entrez_db_searchable("sra") to get searchable terms
sra_search <- entrez_search(db="sra",
                            term="(Tetrahymena thermophila[ORGN] OR Tetrahymena borealis[ORGN]) AND 2013:2015[PDAT]",
                            retmax=10)

# with ids, entrez_() or entrez_summary() to learn more:


# search databases to see where an id shows up
id <- "NR_028961.1"
db_search <- entrez_dbs() %>% 
  setNames(.,.) %>%
  map(~{
  tryCatch({
    entrez_summary(db=.x,id=id)
  },error=function(e) {
    NULL
  })
})



# getting database links -----------------------------------------------------------

all_the_links <- entrez_link(dbfrom="gene", id=351, db="all", cmd="neighbor")
###### cmd can be:
# neighbor (default). Returns a set of IDs in db linked to the input IDs in dbfrom.
# neighbor_score. As 'neighbor”, but additionally returns similarity scores.
# neighbor_history. As ‘neighbor’, but returns web history objects.
# acheck. Returns a list of linked databases available from NCBI for a set of IDs.
# ncheck. Checks for the existence of links within a single database.
# lcheck. Checks for external (i.e. outside NCBI) links.
# llinks. Returns a list of external links for each ID, excluding links provided by libraries.
# llinkslib. As 'llinks' but additionally includes links provided by libraries.
# prlinks. As 'llinks' but returns only the primary external link for each ID.

all_the_links$links
all_the_links$links$gene_nuccore_refseqrna

all_the_links$links$gene_nuccore_refseqrna[1]

# linkouts: external sources of data
paper_links <- entrez_link(dbfrom="pubmed", id=25500142, cmd="llinks")
paper_links$linkouts

# urls
linkout_urls(paper_links)


taxize_summ$pmcrefcount

taxize_summ <- entrez_summary(db="pubmed", id=24555091)
taxize_summ
taxize_summ$authors


y1 <- entrez_summary(db="pubmed",id=yt_search$ids[1])
yy <- entrez_summary(db="pubmed",id=yt_search$ids)





# download fasta ----------------------------------------------------------


#  fasta
gene_ids <- c(351, 11647)
linked_seq_ids <- entrez_link(dbfrom="gene", id=gene_ids, db="nuccore")
linked_transripts <- linked_seq_ids$links$gene_nuccore_refseqrna
head(linked_transripts)

all_recs <- entrez_fetch(db="nuccore", id=linked_transripts, rettype="fasta")

# see url for rettype:
# https://www.ncbi.nlm.nih.gov/books/NBK25499/table/chapter4.T._valid_values_of__retmode_and/

class(all_recs)
nchar(all_recs)

cat(strwrap(substr(all_recs, 1, 500)), sep="\n")

# fetch xml
Tt <- entrez_search(db="taxonomy", term="(Tetrahymena thermophila[ORGN]) AND Species[RANK]")
tax_rec <- entrez_fetch(db="taxonomy", id=Tt$ids, rettype="xml", parsed=TRUE)
class(tax_rec)

tax_list <- XML::xmlToList(tax_rec)
tax_list$Taxon$GeneticCode

# use xpath expressions
tt_lineage <- tax_rec["//LineageEx/Taxon/ScientificName"]
tt_lineage[1:4]
XML::xpathSApply(tax_rec, "//LineageEx/Taxon/ScientificName", XML::xmlValue)



# example: find yt papers and summarize-------------------------------------------------

yt_search <- entrez_search(db="pubmed", term="ying taur[FULL]",retmax=200)
yt_summary <- entrez_summary(db="pubmed",id=yt_search$ids)
yt_pubs <- yt_summary %>% 
  map(~{
    tibble(
      title=.x$title,
      authors=paste(.x$authors$name, collapse=", "),
      date=.x$pubdate,
      journal=.x$source,
      nlmuniqueid=.x$nlmuniqueid,
      pmcrefcount=as.character(.x$pmcrefcount),
      vol.issue=str_glue("{.x$volume}({.x$issue}):{.x$pages}")
    )
  }) %>% list_rbind()
yt_pubs %>% dt()

# use extract_from_esummary
yt_pubs2_temp <- extract_from_esummary(yt_summary, 
                                  elements=c("title","authors","pubdate","source",
                                             "nlmuniqueid","pmcrefcount","volume",
                                             "issue","pages"),
                                  simplify=FALSE)
yt_pubs2 <- yt_pubs2_temp %>% map(function(ref) {
  ref$authors <- paste(ref$authors$name,collapse=", ")
  ref$pmcrefcount <- ifelse(ref$pmcrefcount=="",0,ref$pmcrefcount)
  as_tibble(ref)
}) %>% list_rbind()


# example: get full taxonomy lineage from species ------------------------------------------------------------

ef <- entrez_search(db="taxonomy", term="(Enterococcus faecium[ORGN]) AND Species[RANK]")
ef.xml <- entrez_fetch(db="taxonomy", id=ef$ids, rettype="xml", parsed=TRUE)
ef.list <- XML::xmlToList(ef.xml)

ef.taxonomy <- ef.list$Taxon$LineageEx %>% map(as_tibble) %>% list_rbind()
ef.taxonomy


# example: get data from a paper ---------------------------------------------------

# search for: Succession of microbial consortia in the developing infant gut microbiome (Koenig ... Ley, PNAS 2011)

# search pubmed by title > PMIDs
pm_search <- entrez_search(db="pubmed", term="Succession of microbial consortia in the developing infant gut microbiome")
# examine hits... last one is the one
pm_sum <- entrez_summary(db="pubmed",id=pm_search$ids)
extract_from_esummary(pm_sum, c("uid","title","lastauthor","pubdate"))
# the koenig paper
pmid <- pm_search$ids[3]

# *preview list database link sources.
# these look useful in this case: pubmed_sra, ExternalLink   
acheck <- entrez_link(dbfrom="pubmed", id=pmid, cmd="acheck")
acheck$linked_databses

# find all internal links from the paper. (need db="all")
# pubmed_sra looks useful
all_links <- entrez_link(dbfrom="pubmed", id=pmid, db="all")
all_links$links$pubmed_sra
# sra ids i need:
sra_ids <- all_links$links$pubmed_sra

# external links ?
llinks <- entrez_link(dbfrom="pubmed", id=pmid, cmd="llinks")

# to examine one of the sra links:
# sra1_xml <- entrez_fetch(db="sra",id=sra_ids[1],rettype="xml")
# sra1_preview <- sra1_xml %>% xmlToList() %>% preview_xml_parts() 
# sra1_preview %>% dt()

# pull xml data for all sra ids in dataframe
sra_data <- tibble(sra_id=sra_ids) %>%
  mutate(xml=map(sra_id,~entrez_fetch(db="sra",id=.x,rettype="xml")),
         list=map(xml,~xmlToList(.x,simplify=FALSE)))

# you can view one of the xmls and create a pull expression for hoist:
sra1_preview <- sra_data$xml[[1]] %>% preview_xml_parts()
sra1_preview %>% dt()

r <- sra1_preview %>% 
  mutate(rcode1 = str_glue("xxxx{row_number()} = "),
         rcode2 = map_chr(pluck,deparse1),
         rcode3 = str_glue(", # {str_trunc(val,100)}"),
         rcode=paste0(rcode1,rcode2,rcode3)) %>%
  summarize(rcode=paste(rcode,collapse="\n")) %>%
  mutate(rcode=paste("xxxx <- list(",rcode,"NULL)",sep="\n"))
r$rcode %>% copy.to.clipboard()

pluck_exprs <- list(
  experiment_srx_id = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "IDENTIFIERS", "PRIMARY_ID"),
  experiment_title = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "TITLE"),
  experiment_studyref_srp_id = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "STUDY_REF", "IDENTIFIERS", "PRIMARY_ID"),
  experiment_design_desc = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "DESIGN", "DESIGN_DESCRIPTION"),
  sample_srs_id = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "DESIGN", "SAMPLE_DESCRIPTOR", "IDENTIFIERS", "PRIMARY_ID"),
  sample_descriptors... = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "DESIGN", "SAMPLE_DESCRIPTOR", ".attrs"),
  library_name = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "DESIGN", "LIBRARY_DESCRIPTOR", "LIBRARY_NAME"),
  librar_strategy = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "DESIGN", "LIBRARY_DESCRIPTOR", "LIBRARY_STRATEGY"),
  library_source = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "DESIGN", "LIBRARY_DESCRIPTOR", "LIBRARY_SOURCE"),
  library_select = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "DESIGN", "LIBRARY_DESCRIPTOR", "LIBRARY_SELECTION"),
  experiment_platform = list("EXPERIMENT_PACKAGE", "EXPERIMENT", "PLATFORM", "LS454", "INSTRUMENT_MODEL"),
  submission_sra_id = list("EXPERIMENT_PACKAGE", "SUBMISSION", "IDENTIFIERS", "PRIMARY_ID"),
  submission_organization = list("EXPERIMENT_PACKAGE", "Organization", "Name", "text"),
  study_srp_id = list("EXPERIMENT_PACKAGE", "STUDY", "IDENTIFIERS", "PRIMARY_ID"),
  study_title = list("EXPERIMENT_PACKAGE", "STUDY", "DESCRIPTOR", "STUDY_TITLE"),
  study_type = list("EXPERIMENT_PACKAGE", "STUDY", "DESCRIPTOR", "STUDY_TYPE"),
  study_abstract = list("EXPERIMENT_PACKAGE", "STUDY", "DESCRIPTOR", "STUDY_ABSTRACT"),
  study_center = list("EXPERIMENT_PACKAGE", "STUDY", "DESCRIPTOR", "CENTER_PROJECT_NAME"),
  study_desc = list("EXPERIMENT_PACKAGE", "STUDY", "DESCRIPTOR", "STUDY_DESCRIPTION"),
  study_link_db = list("EXPERIMENT_PACKAGE", "STUDY", "STUDY_LINKS", "STUDY_LINK", "XREF_LINK", "DB"),
  study_link_id = list("EXPERIMENT_PACKAGE", "STUDY", "STUDY_LINKS", "STUDY_LINK", "XREF_LINK", "ID"),
  sample_srs_id2... = list("EXPERIMENT_PACKAGE", "SAMPLE", "IDENTIFIERS", "PRIMARY_ID"),
  sample_external_samn_id = list("EXPERIMENT_PACKAGE", "SAMPLE", "IDENTIFIERS", "EXTERNAL_ID", "text"),
  sample_title = list("EXPERIMENT_PACKAGE", "SAMPLE", "TITLE"),
  taxon_id = list("EXPERIMENT_PACKAGE", "SAMPLE", "SAMPLE_NAME", "TAXON_ID"),
  taxon_scientific_name = list("EXPERIMENT_PACKAGE", "SAMPLE", "SAMPLE_NAME", "SCIENTIFIC_NAME"),
  sample_desc = list("EXPERIMENT_PACKAGE", "SAMPLE", "DESCRIPTION"),
  pool_srs_id = list("EXPERIMENT_PACKAGE", "Pool", "Member", "IDENTIFIERS", "PRIMARY_ID"),
  pool_external_samn_id = list("EXPERIMENT_PACKAGE", "Pool", "Member", "IDENTIFIERS", "EXTERNAL_ID", "text"),
  run_srr_id = list("EXPERIMENT_PACKAGE", "RUN_SET", "RUN", "IDENTIFIERS", "PRIMARY_ID"),
  runset_srx_id = list("EXPERIMENT_PACKAGE", "RUN_SET", "RUN", "EXPERIMENT_REF", "IDENTIFIERS", "PRIMARY_ID"),
  runset_member_srs_id.... = list("EXPERIMENT_PACKAGE", "RUN_SET", "RUN", "Pool", "Member", "IDENTIFIERS", "PRIMARY_ID")
  # tag values
  # sample_metadata = list("EXPERIMENT_PACKAGE", "SAMPLE", "SAMPLE_ATTRIBUTES"),
  # sra_files = list("EXPERIMENT_PACKAGE", "RUN_SET", "RUN", "SRAFiles"),
  # runset_cloudfiles = list("EXPERIMENT_PACKAGE", "RUN_SET", "RUN", "CloudFiles"),
  # runset_statistics = list("EXPERIMENT_PACKAGE", "RUN_SET", "RUN", "Statistics")
)


sra_data_final <- rlang::inject(hoist(sra_data, list, !!!pluck_exprs)) %>%
  hoist_tag_values(list, 
                   sample_metadata = list("EXPERIMENT_PACKAGE", "SAMPLE", "SAMPLE_ATTRIBUTES", "SAMPLE_ATTRIBUTE"),
                   sra_files = list("EXPERIMENT_PACKAGE", "RUN_SET", "RUN", "SRAFiles", "SRAFile"),
                   runset_cloudfiles = list("EXPERIMENT_PACKAGE", "RUN_SET", "RUN", "CloudFiles", "CloudFile"),
                   runset_statistics = list("EXPERIMENT_PACKAGE", "RUN_SET", "RUN", "Statistics", "Read")) %>%
  mutate(sample_metadata=map(sample_metadata,~{
    setNames(.x$VALUE,.x$TAG) %>% bind_rows()
  })) %>%
  unnest_wider(sample_metadata,names_sep="_")

sra_data_final %>% glimpse





# lookup seq accession ids ------------------------------------------------

# faecali
# gi|265678656|ref|NR_028961.1|
# achromobacter
# gi|645321429|ref|NR_118398.1|  

bactlist <- tribble(
  ~Species,                            ~saccver,
  "Faecalibacterium prausnitzii",      "NR_028961.1",
  "Bifidobacterium longum",            "NR_043437.1",
  "Bifidobacterium breve",             "NR_040783.1",
  "[Eubacterium] rectale",             "NR_074634.1",
  "Bifidobacterium catenulatum",       "NR_041875.1",
  "Bifidobacterium pseudocatenulatum", "NR_037117.1",
  "Bifidobacterium kashiwanohense",    "NR_112779.1",
  "Anaerostipes hadrus",               "NR_117139.2",
  "Achromobacter denitrificans",       "NR_118398.1",
  "Achromobacter xylosoxidans",        "NR_118403.1",
  "Bordetella hinzii",                 "NR_027537.1",
  "Achromobacter insuavis",            "NR_117706.1",
  "Achromobacter anxifer",             "NR_117708.1",
  "Achromobacter agilis",              "NR_152013.1",
  "Bordetella tumulicola",             "NR_145922.1",
  "Bacteroides vulgatus",              "NR_112946.1",
  "Gemmiger formicilis",               "NR_104846.1",
  "Blautia luti",                      "NR_041960.1",
  "Bacillus mojavensis",               "NR_118290.1",
  "Bacillus halotolerans",             "NR_115063.1"
)

# test and view one:
id <- bactlist$saccver[1]
xml <- entrez_fetch(db="nucleotide",id=id,rettype="xml")
xmllist <- xml %>% xmlToList()
preview <- xmllist %>% preview_xml_parts()
preview %>% dt()

# create a hoist accessor template....
r <- preview %>% 
  mutate(rcode1 = str_glue("xxxx{row_number()} = "),
         rcode2 = map_chr(pluck,deparse1),
         rcode3 = str_glue(", # {str_trunc(val,100)}"),
         rcode=paste0(rcode1,rcode2,rcode3)) %>%
  summarize(rcode=paste(rcode,collapse="\n")) %>%
  mutate(rcode=paste("xxxx <- list(",rcode,"NULL)",sep="\n"))
r$rcode %>% copy.to.clipboard()


taxon_id_puller <- list("GBSeq",
                        "GBSeq_feature-table",
                        ~.y=="GBFeature" & .x$GBFeature_key=="source",
                        "GBFeature_quals",
                        ~.y=="GBQualifier" & .x$GBQualifier_name=="db_xref" & .x$GBQualifier_value %like% "taxon",
                        "GBQualifier_value")
transcript_puller <- list("GBSeq",
                          "GBSeq_feature-table",
                          ~.y=="GBFeature" & .x$GBFeature_key=="rRNA",
                          "GBFeature_quals",
                          ~.y=="GBQualifier" & .x$GBQualifier_name=="transcription",
                          "GBQualifier_value")

# fetch all data, extract parts
bactdata <- bactlist %>%
  mutate(xml=map(saccver,~entrez_fetch(db="nucleotide",id=.x,rettype="xml")),
         list=map(xml,xmlToList)) %>%
  unnest_xml(list) %>%
  hoist2(list, 
         taxon_id=taxon_id_puller,
         transcript=transcript_puller)






# dealing with xml --------------------------------------------------------


# str <- entrez_fetch(db="biosample",id="31808515",rettype="xml")  
# xml <- xmlInternalTreeParse(str)
xml <- entrez_fetch(db="biosample",id="31808515",rettype="xml",parsed = TRUE)  
lst <- xmlToList(xml)

lst$BioSample$Attributes$Attribute$text
lst$BioSample$Attributes %>% names
# list containing one node 
xml %>% getNodeSet("/BioSampleSet")
# list of nodes
xml %>% getNodeSet("/BioSampleSet/BioSample/Attributes/Attribute")
# same, list of anything called 'Attributes' any depth
xml %>% getNodeSet("//Attribute")

xml %>% getNodeSet("//Attribute[@attribute_name='env_broad_scale']")
xml %>% getNodeSet("//Attribute[@attribute_name='host' or @attribute_name='strain']")
xml %>% getNodeSet("//Attribute[@attribute_name!='ref_biomaterial']")
xml %>% getNodeSet("//Attribute[contains(@attribute_name,'host')]")

# pull value
xml %>% getNodeSet("//Attribute[@attribute_name='host']") %>% xmlValue()
xml %>% xpathSApply("//Attribute[@attribute_name='host']",xmlValue)
# pull other attribute
xml %>% getNodeSet("//Attribute[@attribute_name='host']") %>% map_chr(xmlGetAttr, "harmonized_name")
xml %>% xpathSApply("//Attribute[@attribute_name='host']",xmlGetAttr,"harmonized_name")

# view attributes
xml %>% xpathSApply("//Attribute[@attribute_name]",xmlGetAttr,"attribute_name")
xml %>% xpathSApply("//Attribute[@attribute_name]",xmlValue)

xml %>% xpathSApply("//Attribute[@attribute_name]",function(x) {
  attr <- xmlGetAttr(x,"attribute_name")
  val <- xmlValue(x)
  str_glue("{attr}={val}")
})
xml %>% getNodeSet("//Attribute[@attribute_name='host']")
xml %>% xpathSApply("//Attribute[@attribute_name='host']")




# find all taxids ---------------------------------------------------------





# Achromobacter denitrificans       taxon:32002  
tax_search <- entrez_search(db="taxonomy", term="Achromobacter denitrificans")
taxid <- tax_search$ids

### find all references to this taxid
# all_tax_links <- entrez_link(dbfrom="taxonomy", id=taxid, db="all")
# all_tax_links$links
# all_tax_links$links %>% map_int(length)


# we are checking linked biosamples.
biosample_links <- entrez_link(dbfrom="taxonomy", id=taxid, db="biosample")
biosample_ids <- biosample_links$links$taxonomy_biosample

biosample <- tibble(.id=biosample_ids) %>%
  mutate(xml=map(.id,~entrez_fetch(db="biosample",id=.x,rettype="xml"),.progress=TRUE),
         list=map(xml,xmlToList)) %>%
  unnest_xml(list)

biosample$list[[1]]$BioSample$Attributes


# fix the attributes
biosample2 <- biosample %>%
  hoist(list, attributes = list("BioSample","Attributes")) %>%
  mutate(attributes=map(attributes,function(samp_attr) {
    map(samp_attr,function(attr) {
      cbind(tibble(text=attr$text),bind_rows(attr$.attrs))
    }) %>% list_rbind()
  }))
# biosample2$BioSample..Attributes..Attribute[[1]] %>% preview_xml_parts() %>% dt

## explore attributes
# xx <- biosample2 %>% select(.id,attributes) %>%
#   unnest(attributes) 
# xx %>% group_by(attribute_name) %>%
#   summarize(n=n(),
#             example=tab(text,as.char = TRUE),
#             .groups="drop") %>%
#   mutate(hit=attribute_name %in% env.attrs) %>% 
#   arrange(!hit,desc(n)) %>%
#   dt()

### write function, given taxid, get environment breakdown

env.attrs <- c("broad-scale environmental context", "derived-from", 
               "env_biome", "env_broad_scale", "env_feature", "env_local_scale", 
               "env_material", "env_medium", "environment (biome)", 
               "environment (feature)", "environment (material)", 
               "environment_biome", "environmental-sample", "environmental medium", 
               "environmental_sample", "geo_loc_name", "habitat", 
               "host", "host_description", "isolation-source", "isolation source", 
               "isolation_source", "local environmental context", 
               "metagenome-source", "metagenome_source", "project name", 
               "sample-type", "sample_type")

tax_search <- entrez_search(db="taxonomy", term="Faecalibacterium prausnitzii")
taxid <- tax_search$ids

get.habitat <- function(taxid,max=100) {
  
  biosample_links <- entrez_link(dbfrom="taxonomy", id=taxid, db="biosample")
  biosample_ids <- biosample_links$links$taxonomy_biosample
  n.ids <- length(biosample_ids)
  cli::cli_alert("{n.ids} sample IDs found.")
  if (n.ids>max) {
    cli::cli_alert("sampling {max}...")
    biosample_ids <- biosample_ids %>% sample(size=max)
  }
  biosample <- tibble(.id=biosample_ids) %>%
    mutate(.xml=map(.id,~entrez_fetch(db="biosample",id=.x,rettype="xml"),.progress=TRUE),
           .list=map(.xml,xmlToList))
  # biosample$.list[[1]] %>% preview_xml_parts() %>% dt()
  
  biosample2 <- biosample %>%
    hoist(.list, 
          title = list("BioSample", "Description", "Title"),
          organism = list("BioSample", "Description", "Organism", "OrganismName"),
          attributes = list("BioSample","Attributes"),.remove=FALSE) %>%
    mutate(attributes=map(attributes,function(samp_attr) {
      map(samp_attr,function(attr) {
        cbind(tibble(text=attr$text),bind_rows(attr$.attrs))
      }) %>% list_rbind()
    })) %>% 
    select(.id,title,organism,attributes,everything())
  
  biosample3 <- biosample2 %>%
    mutate(habitat=map(attributes,~{
      .x %>% select(text,attribute_name) %>%
        filter(attribute_name %in% env.attrs,
               text %notilike% "missing|not collected")
    }))
  # all.attributes <- biosample2 %>% select(.id,attributes) %>%
  #   unnest(attributes) %>% select(.id,text,attribute_name)
  # habitats <- all.attributes %>%
  #   filter(attribute_name %in% env.attrs, text %notilike% "missing|not collected")
  # leftovers <- all.attributes %>% filter(attribute_name %notin% env.attrs) %>% group_by(attribute_name) %>%
  #   summarize(n=n(), text=paste(unique(text),collapse="\n"), .groups="drop") %>% arrange(desc(n))
  # habitats %>% dt()
  # leftovers %>% dt()
  biosample3
}

bact.taxids <- tribble(
  ~Species,                            ~taxon_id,
  "Faecalibacterium prausnitzii",      "853",
  "[Eubacterium] rectale",             "515619",
  "Achromobacter denitrificans",       "32002",
  "Bordetella tumulicola",             "1649133",
  "Bacteroides vulgatus",              "821",
  "Gemmiger formicilis",               "745368",
  "Bacillus halotolerans",             "260554"
)
search_attributes <- function(data,col,patterns,test=FALSE) {
  col <- enquo(col)
  col.nhit <- paste0(as_label(col),".nhit")
  
  attr <- data %>%
    select(taxon_id,data) %>%
    mutate(.n.samples=map_int(data,nrow)) %>%
    unnest(data) %>%
    unnest(habitat) %>%
    select(taxon_id,.id,.n.samples,text,attribute_name)
  
  if (test) {
    cli::cli_alert_info("Returning attributes")
    return(attr)
  }
  hitvars <- paste0(".hit",seq_along(patterns))
  bact <- attr
  for (i in seq_along(hitvars)) {
    hitvar <- hitvars[i]
    pattern <- patterns[i]
    bact <- bact %>% mutate(!!sym(hitvar):=text %ilike% pattern)
  }
  bact <- bact %>%
    group_by(taxon_id,.id,.n.samples) %>%
    summarize(across(.cols=all_of(hitvars),.fns=any),
              .groups="drop") %>%
    rowwise() %>% 
    mutate(.hit=all(c_across(all_of(hitvars)))) %>%
    ungroup() %>%
    select(-all_of(hitvars)) %>%
    group_by(taxon_id,.n.samples) %>%
    summarize(.nhit=sum(.hit),
              .groups="drop") %>%
    mutate(.pcthit=.nhit/.n.samples) %>%
    rename(!!col:=.pcthit) %>%
    select(-.n.samples,-.nhit)
  data %>% left_join(bact,by="taxon_id")
}

bacteria <- bact.taxids %>%
  mutate(data=map(taxon_id,get.habitat,.progress=TRUE))

re.human <- "human|homo sapiens"
re.gut <- "gut|stool|fa?eces|fecal|intestine|digestive system|colon"
re.environment <- "Root|plant|seeds|milk|leaves|sediment|marine|metal|plastic|river|soil|water|estuarine|wood|subway|terrestrial|shore|\\bsea\\b|urban|sewage|sludge|washroom"
re.culture <- "culture"

# xx <- bacteria %>% search_attributes(gut,patterns=re.gut,test=T)
# xx$text %>% regex.widget(re.human,
#                          re.gut,
#                          re.environment,
#                          n_fields = 4)



bacteria2 <- bacteria %>%
  mutate(n.samples=map_int(data,nrow)) %>%
  search_attributes(gut,patterns=re.gut) %>%
  search_attributes(human,patterns=re.human) %>%
  search_attributes(human_gut,patterns=c(re.human,re.gut)) %>%
  search_attributes(environment,patterns=re.environment) %>%
  search_attributes(culture,patterns=re.culture)




bacteria2 %>% 
  mutate(across(.cols=where(is.double),.fns=scales::percent))


bioproject <- tibble(id=bioproject_ids) %>%
  mutate(xml=map(id,~entrez_fetch(db="bioproject",id=.x,rettype="xml")),
         list=map(xml,xmlToList)) %>%
  
  bioproject$list[[1]] %>% preview_xml_parts() %>% dt()
bioproject$list[[10]] %>% preview_xml_parts() %>% dt()
biosample$list[[1]] %>% preview_xml_parts() %>% dt()
biosample$list[[10]] %>% preview_xml_parts() %>% dt()



