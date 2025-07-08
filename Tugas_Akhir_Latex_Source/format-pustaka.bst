%%
%% This is file `pustaka.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% merlin.mbs  (with options: `ay,nat,nm-rev,key-yr,m-cite,m-etal,url,url-blk')
%% ----------------------------------------
%% *** BibTeX style file for natbib package ***
%%
%% Copyright 1993-2009 Patrick W Daly
%% Max-Planck-Institut fuer Aeronomie
%% Max-Planck-Str. 2
%% D-37191 Katlenburg-Lindau
%% GERMANY
%% E-mail: daly@mps.mpg.de
%%
%% This program can be redistributed and/or modified under the
%% terms of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%%
%% This file is part of the natbib package.
%% ----------------------------------------
%%
%% HISTORY
%% Mofified from plainnat.bst
%% 1. Changed to author-year style
%% 2. Used name-year format for labels
%% 3. Reversed author names in bibliography
%% 4. Added some functions for manipulating names
%% 5. Changed all functions to use new name functions
%% 6. Changed calc.label to produce author-year labels
%% 7. Changed all entry types to use author-year style
%% 8. Added comma after author list
%% 9. Added new function REVsort.name
%% 10. Changed format.names to use REVsort.name
%% 11. Removed all caps for author names
%% 12. Changed presentation of titles to sentence case
%% 13. Added comma after year
%% 14. Added URL field
%% 15. Added block for URL
%%
ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
    url
  }
  {}
  { label extra.label sort.label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { new.block "Tersedia di: \url{" url * "}" * }
  if$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { "{vv~}{ll}{, jj}{, f.}" author format.names }
  if$
}

FUNCTION {get.bbl.editor}
{ editor num.names$ #1 >
    { s name.format$ }
    { s #1 "{vv~}{ll}" format.name$ }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { ", eds." * }
        { ", ed." * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$
    }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
  #1 'i :=
  t text.length$ 'len :=
  { i len <= }
  { t i #1 substring$ "-" =
      { t i #1 substring$ "-" =
          { "--" *
            #1 'i :=
            t i #1 + len i #1 - substring$ 't :=
            len #2 - 'len :=
          }
          {   { i #1 + len > }
              { "-" * }
              { t #2 global.month >
                t i #1 + #1 substring$ " " =
                t i #2 + #1 substring$ " " =
                and not
                  { i #1 - text.length$ #3 >
                      { "---" * }
                      { "--" * }
                    if$
                  }
                  { "--" * }
                if$
                #1 'i :=
                t i #1 + len i #1 - substring$ 't :=
                len #2 - 'len :=
              }
            if$
          }
        if$
      }
      { t i #1 substring$ *
        i #1 + 'i :=
      }
    if$
  }
  while$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
        { "" }
        { "there's a month but no year in " cite$ * warning$
          month
        }
      if$
    }
    { month empty$
        'year
        { month " " * year * }
      if$
    }
  if$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "chapter" }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
        { "In " booktitle emphasize * }
        { "In " format.editors * ", " * booktitle emphasize * }
      if$
    }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { "l" }
        { "L" }
      if$
      " edition" * edition "l" change.case$ *
    }
  if$
}

FUNCTION {format.institution}
{ institution empty$
    { "" }
    { institution }
  if$
}

FUNCTION {format.note}
{ note empty$
    { "" }
    { note #1 #1 substring$
      "{" =
        'note
        { note }
      if$
    }
  if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages n.dashify }
  if$
}

FUNCTION {format.publisher.address}
{ publisher empty$
    { "" }
    { address empty$
        { publisher }
        { address ": " * publisher * }
      if$
    }
  if$
}

FUNCTION {format.school}
{ school empty$
    { "" }
    { school }
  if$
}

FUNCTION {format.series.volume}
{ series empty$
    { "" }
    { series
      volume empty$
        'skip$
        { " " * volume * }
      if$
    }
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    { "phdthesis" cite$ * " for " * warning$ }
    { type }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Tech. Rep." }
    'type
  if$
  number empty$
    { "" }
    { " " * number * }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume empty$
    { "" }
    { volume
      number empty$
        'skip$
        { "(" number * ")" * }
      if$
      pages empty$
        'skip$
        { ":" * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {article}
{ output.bibitem
  format.authors output
  author format.key output
  output.year.check
  new.block
  format.title "title" output.check
  new.block
  journal emphasize "journal" output.check
  ", " *
  format.vol.num.pages output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
      editor format.key output
    }
    { format.authors output.nonnull
      crossref missing$
        { "author" }
        { "author" }
      if$
      " " *
      "author" output.check
      author format.key output
    }
  if$
  output.year.check
  new.block
  format.btitle "title" output.check
  crossref missing$
    { new.block
      format.series.volume output
      new.block
      format.publisher.address output
    }
    { new.block
      format.in.ed.booktitle "booktitle" output.check
    }
  if$
  format.edition output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  author format.key output
  output.year.check
  new.block
  format.title "title" output.check
  new.block
  howpublished output
  address output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
      editor format.key output
    }
    { format.authors output.nonnull
      crossref missing$
        { "author" }
        { "author" }
      if$
      " " *
      "author" output.check
      author format.key output
    }
  if$
  output.year.check
  new.block
  format.btitle "title" output.check
  crossref missing$
    { new.block
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.series.volume output
      new.block
      format.publisher.address "publisher" output.check
    }
    { new.block
      format.in.ed.booktitle "booktitle" output.check
      format.chapter.pages "chapter and pages" output.check
    }
  if$
  format.edition output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  output.year.check
  new.block
  format.title "title" output.check
  new.block
  format.in.ed.booktitle "booktitle" output.check
  new.block
  format.series.volume output
  format.chapter.pages output
  new.block
  format.publisher.address output
  format.edition output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  output.year.check
  new.block
  format.title "title" output.check
  new.block
  format.in.ed.booktitle "booktitle" output.check
  new.block
  format.series.volume output
  format.pages output
  new.block
  format.publisher.address output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
        'skip$
        { organization output.nonnull
          organization format.key output
        }
      if$
    }
    { format.authors output.nonnull
      author format.key output
    }
  if$
  output.year.check
  new.block
  format.btitle "title" output.check
  organization address new.sentence.checkb
  organization output
  address output
  format.edition output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  output.year.check
  new.block
  format.title "title" output.check
  new.block
  "Master's thesis" format.thesis.type output.nonnull
  new.block
  format.school "school" output.check
  address output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  author format.key output
  output.year.check
  title howpublished new.sentence.checkb
  format.title output
  howpublished new.sentence.checka
  howpublished output
  format.date output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  output.year.check
  new.block
  format.btitle "title" output.check
  new.block
  "PhD thesis" format.thesis.type output.nonnull
  new.block
  format.school "school" output.check
  address output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization empty$
        { format.title "title" output.check }
        { organization output.nonnull
          organization format.key output
        }
      if$
    }
    { format.editors output.nonnull
      editor format.key output
    }
  if$
  output.year.check
  new.block
  format.btitle "title" output.check
  new.block
  format.series.volume output
  new.block
  format.publisher.address output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  output.year.check
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  new.block
  format.institution "institution" output.check
  address output
  new.sentence
  format.note output
  format.url output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  output.year.check
  new.block
  format.title "title" output.check
  new.sentence
  format.note "note" output.check
  format.url output
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MAC_RO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s len #1 substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  { s nameptr "{f.}" format.name$ 't :=
    nameptr #1 >
      { "   " * }
      'skip$
    if$
    t sortify *
    nameptr #1 + 'nameptr :=
    s num.names$ nameptr >
  }
  {
    s nameptr "{vv~}{ll}" format.name$ 't :=
    t sortify *
    s nameptr "{, jj}" format.name$ 't :=
    t sortify *
    #1 'nameptr :=
    ""
    { s nameptr "{ff}" format.name$ 't :=
      nameptr #1 >
        { " " * }
        'skip$
      if$
      t sortify *
      nameptr #1 + 'nameptr :=
      s num.names$ nameptr >
    }
    while$
  }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4
    chop.word
  chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.sort}
{ editor empty$
    { key empty$
        { "to sort, need editor or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.sort
        'author.sort
      if$
    }
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.label :=
  sort.label
  *
  "    "
  *
  cite$
  *
  #1 sort.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { last.label next.extra }

INTEGERS { last.extra.num number.label }

FUNCTION {init.bib.extra.number}
{ #0 'last.extra.num :=
  "" 'last.label :=
  #1 'number.label :=
}

EXECUTE {init.bib.extra.number}

FUNCTION {author.key.year}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { author format.key }
  if$
  " "
  *
  year field.or.null
  *
}

FUNCTION {editor.key.year}
{ editor empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { editor format.key }
  if$
  " "
  *
  year field.or.null
  *
}

FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.year
    { type$ "proceedings" =
        'editor.key.year
        'author.key.year
      if$
    }
  if$
  'label :=
  year field.or.null #-1 #4 substring$
  'sort.label :=
  label sort.label =
    { "" 'label := }
    'skip$
  if$
  last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { #1 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
}

FUNCTION {forward.pass}
{ last.label "" =
    { number.label #1 + 'number.label := }
    'skip$
  if$
  ext.article.key field.or.null purify$
  'label :=
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ "" =
    'pop$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
}

FUNCTION {make.full.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  s nameptr "{vv~}{ll}" format.name$
  't :=
  nameptr #1 + 'nameptr :=
  { namesleft #1 > }
  { nameptr numnames =
      { s nameptr "{ff }{vv }{ll}{, jj}" format.name$ 'ff :=
        ff "" =
          { " and " * t * }
          { " and " * t * }
        if$
      }
      { s nameptr "{ff }{vv }{ll}{, jj}" format.name$ 'ff :=
        ff "" =
          { ", " * t * }
          { ", " * t * }
        if$
      }
    if$
    #1 'namesleft :=
  }
  while$
}

FUNCTION {output.year.check}
{ year empty$
    { "empty year in " cite$ * warning$
      ""
    }
    { write$
      " "
      *
      year *
      extra.label *
      ""
      *
    }
  if$
}

FUNCTION {author.editor.key.year}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key
          if$
        }
        { editor format.key }
      if$
    }
    { author format.key }
  if$
  " "
  *
  year field.or.null
  *
}

FUNCTION {author.key.organization}
{ author empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { organization }
          if$
        }
        'key
      if$
    }
    { author format.key }
  if$
}

FUNCTION {editor.key.organization}
{ editor empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { organization }
          if$
        }
        'key
      if$
    }
    { editor format.key }
  if$
}

ITERATE {calc.label}

REVERSE {reverse.pass}

EXECUTE {init.state.consts}

EXECUTE {init.bib.extra.number}
