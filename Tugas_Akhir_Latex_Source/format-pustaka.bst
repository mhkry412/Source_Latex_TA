%%
%% This is file `format-pustaka.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% merlin.mbs  (with options: `ay,nat,nm-rev,key-alph,dt-req,yr-per,note-yr,xm-lab,lab-fl,ed-rev,j-rev,tr-rev,pp,ed-au,amp,ord,url,url-nl')
%% ----------------------------------------
%% *** natbib ***
%% BibTeX style for author-year citations
%% Maintained by Patrick W Daly
%% Version 8.31b (2010/04/21)
%% 
%% Modifikasi untuk Bahasa Indonesia
%% ----------------------------------------

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

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
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

INTEGERS { name.ptr names.left num.names }

FUNCTION {format.names}
{ 's :=
  #1 'name.ptr :=
  s num.names$ 'num.names :=
  num.names 'names.left :=
    { names.left #0 > }
    { s name.ptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=
      name.ptr #1 >
        { names.left #1 >
            { ", " * t * }
            { num.names #2 >
                { "," * }
                'skip$
              if$
              t "others" =
                { " " * bbl.etal * }
                { " " * bbl.and * " " * t * }
              if$
            }
          if$
        }
        't
      if$
      't :=
      name.ptr #1 + 'name.ptr :=
      names.left #1 - 'names.left :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { ", " * bbl.editors * }
        { ", " * bbl.editor * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #2 global.max$ substring$ 't :=
          "--" swap$ *
        }
        { t #1 #1 substring$
          swap$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { "" }
    { month empty$
        { year }
        { month " " * year * }
      if$
    }
  if$
  duplicate$ empty$
      { pop$
          ""
      }
      {
          " (" swap$ * ")" *
      }
  if$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.prefix}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$
      swap$ *
      t #2 global.max$ substring$ 't :=
    }
  while$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { bbl.volume volume tie.or.space.prefix
      " " * swap$ * * }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { output.state mid.sentence =
            { " " }
            { " " }
          if$
          series empty$
            { "No." }
            { series }
          if$
          "~" * number *
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { edition "l" change.case$ " " * bbl.edition * }
        { edition "t" change.case$ " " * bbl.edition * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { t empty$ not }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { bbl.pages pages n.dashify tie.or.space.prefix " " * swap$ * * }
        { bbl.page pages tie.or.space.prefix " " * swap$ * * }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
        { "No." }
        { "" }
      if$
      swap$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ "" }
        { ":" * }
      if$
      swap$
      " " *
      pages n.dashify *
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { bbl.chapter }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.prefix " " * swap$ *
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
        { bbl.in booktitle emphasize * }
        { bbl.in booktitle emphasize *
          ", " *
          format.editors *
        }
      if$
    }
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { bbl.techrep }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { "t" change.case$ " " * number * }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
        { "???" }
        { journal emphasize }
      if$
      " \cite{" * crossref * "}" *
    }
    { bbl.in key emphasize * }
  if$
}

FUNCTION {format.crossref.editor}
{ editor #1 "{ff~}{vv~}{ll}{, jj}" format.name$
  " " *
  bbl.etal *
}

FUNCTION {format.book.crossref}
{ volume empty$
    { bbl.in
      " " *
      key emphasize *
      ", " *
      bbl.chapter *
      " " *
      chapter *
    }
    { bbl.in
      " " *
      key emphasize *
    }
  if$
}

FUNCTION {format.incoll.inproc.crossref}
{ bbl.in
  " " *
  key emphasize *
}

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  author format.date * "year" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.num.pages output
    }
    { format.article.crossref output }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "editor" output.check
      editor format.date * "year" output.check
    }
    { format.authors "author" output.check
      author format.date * "year" output.check
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output
    }
  if$
  new.block
  format.edition output
  new.block
  note output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors "author" output.check
  author format.date * "year" output.check
  new.block
  format.title "title" output.check
  howpublished address new.block.checkb
  howpublished output
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "editor" output.check
      editor format.date * "year" output.check
    }
    { format.authors "author" output.check
      author format.date * "year" output.check
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.chapter.pages "chapter and pages" output.check
      new.sentence
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output
    }
  if$
  new.block
  format.edition output
  new.block
  note output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  author format.date * "year" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
      address output
      format.edition output
    }
    { format.incoll.inproc.crossref output
      format.chapter.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  author format.date * "year" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      address empty$
        { organization publisher new.block.checkb
          organization output
          publisher output
        }
        { address output
          organization publisher new.sentence.checkb
          organization output
          publisher output
        }
      if$
    }
    { format.incoll.inproc.crossref output
      format.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
        'skip$
        { organization output
          address output
        }
      if$
    }
    { format.authors "author" output.check }
  if$
  author format.date * "year" output.check
  new.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
        { address new.block.checka
          address output
        }
        'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  new.block
  format.edition output
  new.block
  note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.date * "year" output.check
  new.block
  format.btitle "title" output.check
  new.block
  bbl.mastersthesis format.thesis.type output.nonnull
  school "school" output.check
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors "author" output.check
  author format.date * "year" output.check
  new.block
  format.title "title" output.check
  new.block
  howpublished output
  new.block
  note output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.date * "year" output.check
  new.block
  format.btitle "title" output.check
  new.block
  bbl.phdthesis format.thesis.type output.nonnull
  school "school" output.check
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors "editor" output.check }
  if$
  editor format.date * "year" output.check
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
        { publisher new.block.checka }
        { organization publisher new.block.checkb
          organization output
        }
      if$
      publisher output
    }
    { address output
      new.sentence
      editor empty$
        'skip$
        { organization output }
      if$
      publisher output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  author format.date * "year" output.check
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  author format.date * "year" output.check
  new.block
  format.title "title" output.check
  new.block
  note "note" output.check
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"Januari"}

MACRO {feb} {"Februari"}

MACRO {mar} {"Maret"}

MACRO {apr} {"April"}

MACRO {may} {"Mei"}

MACRO {jun} {"Juni"}

MACRO {jul} {"Juli"}

MACRO {aug} {"Agustus"}

MACRO {sep} {"September"}

MACRO {oct} {"Oktober"}

MACRO {nov} {"November"}

MACRO {dec} {"Desember"}

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

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tr} {"Technical Report"}

MACRO {bbl.and} {"dan"}

MACRO {bbl.etal} {"dkk."}

MACRO {bbl.editors} {"Penyunting"}

MACRO {bbl.editor} {"Penyunting"}

MACRO {bbl.edby} {"disunting oleh"}

MACRO {bbl.edition} {"edisi"}

MACRO {bbl.in} {"Dalam:"}

MACRO {bbl.incollin} {"Dalam:"}

MACRO {bbl.incoll} {"Dalam:"}

MACRO {bbl.inproc} {"Dalam prosiding"}

MACRO {bbl.pages} {"hlm."}

MACRO {bbl.page} {"hlm."}

MACRO {bbl.volume} {"vol."}

MACRO {bbl.number} {"no."}

MACRO {bbl.chapter} {"bab"}

MACRO {bbl.techrep} {"Laporan Teknis"}

MACRO {bbl.phdthesis} {"Tesis Doktoral"}

MACRO {bbl.mastersthesis} {"Tesis Master"}

MACRO {bbl.url} {"URL"}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {format.lab.names}
{ 's :=
  s #1 "{vv~}{ll}" format.name$
  s num.names$ #1 >
    { " " * bbl.etal * }
    'skip$
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { organization #3 #1 substring$ }
          if$
        }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { organization #3 #1 substring$ }
          if$
        }
        'key
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.organization.label
        { type$ "manual" =
            'author.key.organization.label
            'author.key.label
          if$
        }
      if$
    }
  if$
  'label :=
  year empty$
    { "????" }
    { year #2 #2 substring$ }
  if$
  'sort.label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'name.ptr :=
  ""
  s num.names$ 'num.names :=
  num.names 'names.left :=
    { names.left #0 > }
    { s name.ptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      name.ptr #1 >
        {
          " " * bbl.and * " " *
          * t *
        }
        't
      if$
      name.ptr #1 + 'name.ptr :=
      names.left #1 - 'names.left :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
}

FUNCTION {author.sort}
{ author empty$
    { editor empty$
        { organization empty$
            { key empty$
                { "to " #3 sort.format.title title * }
                'key
              if$
            }
            { organization sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to " #3 sort.format.title title * }
            'key
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to " #3 sort.format.title title * }
            'key
          if$
        }
        { organization sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to " #3 sort.format.title title * }
            'key
          if$
        }
        { organization sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ calc.label
  label sort.label * "    " *
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "manual" =
            'author.organization.sort
            'author.sort
          if$
        }
      if$
    }
  if$
  'sort.key$ :=
  sort.key$
  *
  "    "
  *
  cite$
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { last.label next.extra }

INTEGERS { last.extra.num number.label }

FUNCTION {initialize.extra.label.stuff}
{ #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'last.extra.num :=
  #0 'number.label :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  extra.label 'next.extra :=
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  label extra.label * 'label :=
  next.extra 'next.extra :=
}

EXECUTE {initialize.extra.label.stuff}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {bib.sort.order}
{ sort.label
  "    "
  *
  author.sort
  *
  "    "
  *
  title
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {bib.sort.order}

SORT

ITERATE {call.type$}
