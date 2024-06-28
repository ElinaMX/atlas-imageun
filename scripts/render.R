#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#

# install.packages('babelquarto', repos = c('https://ropensci.r-universe.dev', 'https://cloud.r-project.org'))
library(babelquarto)

parent_dir <- "."
book_dir <- "."
book_path <- file.path(parent_dir, book_dir)

#------------------------------------------------------------------------------#

babelquarto::register_main_language(main_language = "en",
                                    book_path = book_path)


babelquarto::register_further_languages(further_languages = "fr", 
                                        book_path = book_path)

#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#



# FINAL = POUR MISE EN LIGNE
babelquarto::render_book(file.path(parent_dir, book_dir))

#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#

# PC Elina
babelquarto::render_book(file.path(parent_dir, book_dir),
                         site_url = "file:///C:/Users/FR%20CIST/Documents/IMAGEUN_ELina/datapaper/_book")
# laptop Elina
babelquarto::render_book(file.path(parent_dir, book_dir),
                         site_url = "file:///C:/Users/elina/Documents/r/datapaper/public")



