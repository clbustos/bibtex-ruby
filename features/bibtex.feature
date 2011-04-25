Feature: Parse BibTeX files
	As a hacker who works with bibliographies
	I want to be able to parse BibTeX files using Ruby

	Scenario: A BibTeX file with lots of objects and comments
		When I parse the following file:
		"""
		%%
		%% This BibTeX file contains all the examples of valid BibTeX objects
		%% in Xavier Decoret's `A summary of BibTeX' at
		%% http://artis.imag.fr/~Xavier.Decoret/resources/xdkbibtex/bibtex_summary.html
		%%

		@Article{py03,
		  author = {Xavier D\'ecoret},
		  title  = "PyBiTex",
		  year   = 2003
		}

		@Article{key03,
		    title = "A {bunch {of} braces {in}} title"
		}

		@Article{key01,
		    author = "Simon {"}the {saint"} Templar", 
		    }

		@Article{key01,
		    title = "The history of @ sign"
		}

		Some {{comments} with unbalanced braces
		....and a "commented" entry...

		Book{landru21,
		  author =   {Landru, Henri D\'esir\'e},
		  title =  {A hundred recipes for you wife},
		  publisher =  {Culinary Expert Series},
		  year =   1921
		}

		..some other comments..before a valid entry...

		@Book{steward03,
		  author =   { Martha Steward },
		  title =  {Cooking behind bars},
		  publisher =  {Culinary Expert Series},
		  year =   2003
		}

		...and finally an entry commented by the use of the special Comment entry type.

		@Comment{steward04,
		  author =   {Martha Steward},
		  title =  {Cooking behind bars},
		  publisher =  {Culinary Expert Series},
		  year =   2004
		}
		[Note: here BibTeX-Ruby differs from bibtex in that it does not parse
		the nested book as an object, but treats it as a comment!]
		@Comment{
		  @Book{steward04,
		    author =   {Martha Steward},
		    title =  {Cooking behind bars},
		    publisher =  {Culinary Expert Series},
		    year =   2004
		  }
		}

		@String{mar = "march"}

		@Book{sweig42,
		  Author =   { Stefan Sweig },
		  title =  { The impossible book },
		  publisher =  { Dead Poet Society},
		  year =   1942,
		  month =      "1~" # mar
		}


		@String {firstname = "Xavier"}
		@String {lastname  = "Decoret"}
		@String {email      = firstname # "." # lastname # "@imag.fr"}

		@preamble {"This bibliography was generated on \today"}

		@String {maintainer = "Xavier D\'ecoret"}

		@preamble { "Maintained by " # maintainer }

		"""
		Then my bibliography should contain the following numbers of elements:
			| article | book | comment | string | preamble | total |
			| 4       | 2    | 2       | 5      | 2        | 15    |
		And my bibliography should contain an entry with key "sweig42"
		But my bibliography should not contain an entry with key "steward04"
