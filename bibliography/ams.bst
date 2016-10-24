    %  BibTex bibliography for the American Meteorological Society
    % this file is based on the `harvard' family of files
    % version 0.99a for BibTeX versions 0.99a or later, LaTeX version 2.09.
    % Copyright (C) 1991, all rights reserved.
    % Copying of this file is authorized only if either
    % (1) you make absolutely no changes to your copy, including name, or
    % (2) if you do make changes, you name it something other than
    % btxbst.doc, plain.bst, unsrt.bst, alpha.bst, abbrv.bst, agsm.bst,
    % dcu.bst, cje.bst, aer.bst, or kluwer.bst.
    % This restriction helps ensure that all standard styles are identical.

    % ACKNOWLEDGEMENT:
    %   This document is a modified version of aer.bst, which is a modified version
    %   of alpha.bst to which it owes much of its functionality.
    
    % AUTHOR
    %   Larissa Reames, School of Meteorology, The University of Oklahoma
    %   e-mail: lreames@ou.edu

ENTRY
  { address author booktitle chapter doi edition editor howpublished institution
    journal key month note number organization pages publisher school
    series title type url volume year code}
  { field.used bsnum}
  { extra.label label sort.label short.list newlabel temp.extra testab.label}


FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   {}
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    {}
  if$
}

INTEGERS {quoted italic bold plain attribute
        space comma tiedcomma semicolon colon period block empty separator
        prev.separator next.separator next.attribute rightbracket leftbracket voltext doipre old.bsnum isams}

STRINGS { s temp f name.list first.name.format later.name.formats name.style urlend tempextra bsnum.cur}

FUNCTION {init.state.consts}
{
  #100  'quoted :=
  #200  'italic :=
  #300  'bold   :=
  #400  'plain  :=
  
  #8 'doipre :=
  #7 'space :=
  #6 'comma :=
%  #5 'tiedcomma :=
%  #4 'semicolon :=
  #3 'colon :=
  #2 'period :=
  #1 'block :=
  #0 'empty :=
}

FUNCTION {output2}
{
% Wrap the attribute.
    attribute bold = {"{\bf " swap$ * "}" *} {} if$
    attribute italic = {"{\it " swap$ * "}" *} {} if$
    attribute quoted = {"``" swap$ * "''" *} {} if$
% Append additional separators
    separator doipre = {", doi:" * empty 'separator :=} {} if$
    separator comma = {"," * space 'separator :=} {} if$
%    separator tiedcomma = {",~" * empty 'separator :=} {} if$
    separator space = {" " *} {} if$
    write$
    separator block = {newline$ "\newblock " write$} {} if$
% Update variables, and put the new string back on the stack
    next.attribute 'attribute :=
    next.separator 'separator :=
    temp
}

% <string> <separator> <string> <attribute> <final separator> output <string>
FUNCTION {output.nonnull}
{   'next.separator :=
    'next.attribute :=
    'temp :=
    'prev.separator :=
% If the new separator is stronger than the previous one, use it.
    prev.separator separator < {prev.separator 'separator :=} {} if$
% Append most separators to the string.
    separator block = {add.period$} {} if$
    separator period = {add.period$ space 'separator :=} {} if$
%    separator semicolon = {";" * space 'separator :=} {} if$
    separator colon = {":" * space 'separator :=} {} if$
    separator comma = attribute quoted = and
        {"," * space 'separator :=} {} if$
    output2
}

FUNCTION {output}
{   'next.separator :=
    'next.attribute :=
    duplicate$ empty$
        {pop$ pop$}
        {next.attribute next.separator output.nonnull}
        if$
}

FUNCTION {output.check}
{   's :=
    'next.separator :=
    'next.attribute :=
    duplicate$ empty$
        {pop$ pop$ "empty " s * " " * cite$ * warning$ }
        {next.attribute next.separator output.nonnull}
        if$
}

FUNCTION {item.check}
{ 'temp :=
  empty$
    { "empty " temp * " " * cite$ * warning$ }
    {}
  if$
}

FUNCTION {plain.space} { plain space }

FUNCTION {plain.space.output} { plain.space output }

FUNCTION {plain.output} {plain output}

FUNCTION {plain.period.output} {plain period output}

FUNCTION {plain.comma} { plain comma }

FUNCTION {plain.comma.output} { plain.comma output }

FUNCTION {plain.colon} { plain colon }

FUNCTION {plain.colon.output} {plain.colon output}

FUNCTION {fin.article}
{block note plain.space.output
  period "" plain empty output.nonnull pop$
  newline$
}
FUNCTION {fin.entry}
{ 
  block note plain.space.output
  period "" plain empty output.nonnull pop$
  newline$
}

FUNCTION {date.block}
{
  ": " *
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    {}
  if$
}

FUNCTION {bibinfo.check}
{ swap$
  duplicate$ missing$
    {
      pop$ pop$
      ""
    }
    { duplicate$ empty$
        {
          swap$ pop$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}


FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

FUNCTION {quote}
{ duplicate$ empty$
    { pop$ "" }
    { add.period$ "`" swap$ * "'" * }
  if$
}


% <prev name list> <new name list> compare.names <modified name list>
INTEGERS {len1 len2 i}
FUNCTION {compare.names}
{   's :=
    'temp :=
    temp num.names$ 'len1 :=
    s num.names$ 'len2 :=
% len1 := min(len1,len2)
    len1 len2 > {len2 'len1 :=} {} if$
% start with an empty string, then while the components are the same
% add "\bysame"
    ""
    #1 'i :=
    {i len1 > not}
    { temp i "{ll~}{vv}{, jj}{, ff}" format.name$
% duplicate$ i int.to.str$ * warning$
      s i "{ll~}{vv}{, jj}{, ff}" format.name$
% duplicate$ i int.to.str$ * warning$
      =
        { #1 i < {" and " *} {} if$
          "\bysame{}" * i #1 + 'i :=}
        {#-1 'len1 :=}
        if$
      }
    while$
% add the rest of the second string
    {i len2 > not}
    { #1 i < {" and " *} {} if$
      s i "{ll~}{vv}{, jj}{, ff}" format.name$ *
      i #1 + 'i :=
      }
    while$
% duplicate$ warning$
}

FUNCTION {compare.names.bsame}
{   's :=
    'temp :=
    temp num.names$ 'len1 :=
    s num.names$ 'len2 :=
% len1 := min(len1,len2)
    len1 len2 > {len2 'len1 :=} {} if$
% start with an empty string, then while the components are the same
% add "\bysame"
    ""
    #1 'i :=
    {i len1 > not}
    { temp i "{ff }{vv }{ll}{ jj}" format.name$
% duplicate$ i int.to.str$ * warning$
      s i "{ff }{vv }{ll}{ jj}" format.name$
% duplicate$ i int.to.str$ * warning$
      =
        { #1 i < {" and " *} {} if$
          "" * i #1 + 'i :=}
        {#-1 'len1 :=}
        if$
      }
    while$
% add the rest of the second string
    {i len2 > not}
    { %#1 i < {" and " *} {} if$
      s i "{ff }{vv }{ll}{ jj}" format.name$ *
      i #1 + 'i :=
      }
    while$
% duplicate$ warning$
}

%FUNCTION{init.doi.string}
%{
 %", doi:" 'doipre :=
%}

INTEGERS { nameptr namesleft numnames }

FUNCTION {write.doi}
{doi empty$
    {skip$}
    { "\doiprefix" doi * "\doisuffix" * write$ newline$ }
  if$
}

FUNCTION {format.names}
{ 'name.list :=
  'name.style :=
  'later.name.formats :=
  's := % binary separator
  'first.name.format :=
  #1 'nameptr :=
  name.list num.names$ 'numnames :=
  %name.list top$
% If we're to make this entry bold or something, prepend to the string of names
  %name.style "" = {} {"{" name.style *} if$
  numnames 'namesleft :=
       { namesleft #0 > }
    { name.list nameptr 
      duplicate$ #1 >
        { "{f.~}{vv~}{ll}{~jj}" }
        { "{vv~}{ll}{, f.}{~jj}" }
      if$
      format.name$      
      'temp :=
      nameptr #1 >
        {
           numnames #8 >
           {#0 'namesleft :=}
           {}
           if$
          namesleft #1 >
            { ", " * temp * }
            { numnames #8 >
                { ", and~Coauthors" * }
                {nameptr #2 =   % handle ", and" vs " and "
                    {s * temp *}
                    {", and " * temp * }
                    if$
                }
                if$
            }
            if$
        }
        'temp
        
        if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$% If we're to make this entry bold or something, append to the string of names
  %name.style "" = {} {"}" * *}  if$
}

FUNCTION {format.authors}
{ 'temp :=
     "{vv~}{ll}{, f.}{~jj}"  " and " "{f.~}{vv~}{ll}{~jj}"  "" temp
                format.names
}

FUNCTION {format.names.key}
{ %int.to.chr$ 'bsnum.cur :=
  'name.list :=
  'name.style :=
  'later.name.formats :=
  's := % binary separator
  'first.name.format :=
  %prev.author.bsame author format.bsnum.key
  #1 'nameptr :=
  bsnum int.to.str$ 'bsnum.cur :=
  name.list num.names$ 'numnames :=
% If we're to make this entry bold or something, prepend to the string of names
  name.style "" = {} {"{" name.style *} if$
  numnames 'namesleft :=
       { namesleft #0 > }
    { name.list nameptr nameptr #1 = {first.name.format} {later.name.formats} if$
                format.name$  'temp :=
                %"" * #1 int.to.chr$ *
      nameptr #1 >
        { %numnames #8 >
           %{#0 'namesleft :=}
           %{}
           %if$
	 nameptr #2 =   % handle ", and" vs " and "
             {s * bsnum.cur *}
             {s * }
             if$
           nameptr bsnum =
           bsnum #1 >
           and
                  {#0 'namesleft :=
                   #0 'nameptr :=
	   	      s * temp *}
                   {}
    	     if$             

          namesleft #1 >
            { "" * temp * }
            { numnames #8 >
                { ", and~Coauthors" * }
                { bsnum #2 <
                  nameptr #0 > 
                  and
                    {s * temp *}
                    {}
                    %{", and " * temp * }
                    if$
                }
                if$
            }
            if$
        }
        'temp
        if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$% If we're to make this entry bold or something, append to the string of names
  name.style "" = {} {"}" * *}  if$
}
FUNCTION {format.names.key.2}
{
 'name.list :=
  'name.style :=
  'later.name.formats :=
  's := % binary separator
  'first.name.format :=
  %prev.author.bsame author format.bsnum.key
  #1 'nameptr :=
  %bsnum int.to.str$ 'bsnum.cur :=
  name.list num.names$ 'numnames :=
% If we're to make this entry bold or something, prepend to the string of names
  name.style "" = {} {"{" name.style *} if$
  numnames 'namesleft :=
  numnames #3 >
  	{#3 'numnames :=}
	{}
	if$
       { namesleft #0 > }
    { name.list nameptr nameptr #1 = {first.name.format} {later.name.formats} if$
                format.name$  'temp :=
                %"" * #1 int.to.chr$ *
      nameptr #1 >
        { nameptr #2 =   % handle ", and" vs " and "
             {s * numnames int.to.str$ *
             #0 'namesleft :=}
             {s * }
             if$
%           nameptr bsnum =
%           bsnum #1 >
%           and
%                  {#0 'namesleft :=
%                   #0 'nameptr :=
%	   	      s * temp *}
%                   {}
%    	     if$             
%
%          namesleft #1 >
%            { "" * temp * }
%            { numnames #8 >
%                { ", and~Coauthors" * }
%                { bsnum #2 <
%                  nameptr #0 > 
 %                 and
%                    {s * temp *}
%                    {}
%                    %{", and " * temp * }
%                    if$
%                }
%                if$
%            }
%            if$
        }
        'temp
        if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$% If we're to make this entry bold or something, append to the string of names
  name.style "" = {} {"}" * *}  if$

}


FUNCTION {format.authors.key}
{ 'temp :=
    "{vv~}{ll}{jj}{f.}" "" "{vv~}{ll}{jj}{f.}" "" temp		%"{f.~}{vv~}{ll}{, jj}" "" temp
                format.names.key.2
}




FUNCTION {format.editors}
{ 'temp :=
    "{vv~}{ll}{, jj}{, f.}" " and " "{f.~}{vv~}{ll}{, jj}" ""
                temp format.names
      editor num.names$ #1 >
        { ", eds" * }
        { ", ed." * }
      if$
}

FUNCTION {format.editors.notkey}
{ editor empty$
    { "" }
    { "{f.~}{vv~}{ll}{, jj}" " and " "{f.~}{vv~}{ll}{, jj}" ""
                editor format.names
      editor num.names$ #1 > {", Eds."} {", Ed."} if$
      *
    }
  if$
}

FUNCTION {format.date}
{ space year colon plain.space.output %space extra.label plain.colon.output
}


FUNCTION {format.title}
{ colon title plain period }

FUNCTION {n.dashify}
{ 'temp :=
  ""
    { temp empty$ not }
    { temp #1 #1 substring$ "-" =
        { temp #1 #2 substring$ "--" = not
            { "--" *
              temp #2 global.max$ substring$ 'temp :=
            }
            {   { temp #1 #1 substring$ "-" = }
                { "-" *
                  temp #2 global.max$ substring$ 'temp :=
                }
              while$
            }
          if$
        }
        { temp #1 #1 substring$ *
          temp #2 global.max$ substring$ 'temp :=
        }
      if$
    }
  while$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "Vol." volume tie.or.space.connect
      series empty$
        {}
        { ", " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.bvolume.output}
  {period format.bvolume plain.space.output}

FUNCTION {mid.sentence.q}
{
    separator empty = separator block = separator period = or or not
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        {series field.or.null}
        { mid.sentence.q
            { "number" }
            { "Number" }
          if$
          number tie.or.space.connect
          series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { add.period$ " In " * series quote * }
          if$
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition.output}
{ edition empty$
    { }
    { comma edition
      mid.sentence.q { "l" } { "t" } if$
      change.case$ " ed." *
      plain.space.output
    }
  if$
}

FUNCTION {format.publisher.address}
{
        publisher empty$
            {}
            {type$ "book" =
            	{volume empty$
		     {period publisher plain.comma output}
                      {comma publisher plain.comma output}
                  if$
                 }
                 {comma publisher plain.comma output}
            if$
            }
         if$
         
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 'temp :=
  #0 'multiresult :=
    { multiresult not
      temp empty$ not
      and
    }
    { temp #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { temp #2 global.max$ substring$ 'temp := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { 
    code empty$
        {}
        {"" code  n.dashify *}
     if$     
    }
    { pages multi.page.check
        { "" pages n.dashify * }
         {type$ "inproceedings" =
         	{"" pages *}
         	{pages "~pp." * }
	if$
	}
      if$
    }
  if$
}

FUNCTION {output.month.year}
  {  
   space newlabel plain.space output.nonnull
  }
  
FUNCTION {output.extralabel}
{
  newlabel write$
 }

FUNCTION {output.vol.num.pages.doi}
{ space volume bold space output
  number empty$
  isams #1 =
  or
    {}
    { space "(" number * ")" * plain.comma output.nonnull
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        {}
      if$
    }
  if$
% "*** a" warning$
  comma 'next.separator :=      % hack
  pages empty$
    {
    code empty$
    	{}
	{comma format.pages plain.space.output}
     if$
    }
    { number empty$ volume empty$ and
        { comma format.pages plain.space.output }
        { comma format.pages plain.space.output
          %doipre doi plain.space.output
        }
      if$
    }
  if$
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
        {}
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {output.in.ed.booktitle}
{ booktitle "booktitle" item.check
  comma "" plain.space output.nonnull
  editor empty$
    { space booktitle italic space output.nonnull}
    { space booktitle italic comma output.nonnull
          space format.editors.notkey plain.space  output.nonnull
     }
     if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    {}
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    {}
    { pop$
      type "t" change.case$
    }
  if$
}


FUNCTION {format.tr.number.pages}
{ type empty$
    { "Tech. Rep." }
    'type
  if$
  number empty$
    {  }
    { number  tie.or.space.connect}
  if$
  volume empty$
  {}
  {", Vol. " * volume *
  }
  if$
   pages empty$
     {}
    { ", " * format.pages * }
     if$
 
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
        { "need key or journal for " cite$ * " to crossref " * crossref *
          warning$
          ""
        }
        { "{\it " journal * "\/} \cite{" * crossref * "}" *}
      if$
    }
    { add.period$ "\citeasnoun{" crossref * "}" * }
  if$
 
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      " "
    }
    { "Vol." volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { series empty$
            { "need editor, key, or series for " cite$ * " to crossref " *
              crossref * warning$
              "" *
            }
            { "{\it " * series * "\/} \cite{" * crossref * "}" *}
          if$
        }
        { " \citeasnoun{" * crossref * "}" * }
      if$
    }
    { " \citeasnoun{" * crossref * "}" * }
  if$
}

FUNCTION {output.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { booktitle empty$
            { "need editor, key, or booktitle for " cite$ * " to crossref " *
              crossref * warning$
            }
            { period " {\it " booktitle * "\/}" * " \cite{" * crossref * "}" * plain.space output.nonnull}
          if$
        }
        { period " \citeasnoun{" crossref * "}" * plain.space output.nonnull}
      if$
    }
    { period " \citeasnoun{" crossref * "}" * plain.space output.nonnull}
  if$
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

INTEGERS { author.field editor.field organization.field title.field key.field }

FUNCTION {init.field.constants}
{ #0 'author.field :=
  #1 'editor.field :=
  #2 'organization.field :=
  #3 'title.field :=
  #4 'key.field :=
}

FUNCTION {format.lab.names.abbr}
{ 'name.list :=
  name.list num.names$ 'numnames :=
  numnames #1 >
    { numnames #2 >
        { name.list #1 "{vv~}{ll}" format.name$ " et~al." * }
        { name.list #2 "{f. }{vv }{ll}{ jj}" format.name$ " et~al." =
            { name.list #1 "{vv~}{ll}" format.name$ " et~al." * }
            { name.list #1 "{vv~}{ll}" format.name$ " and " *
              name.list #2 "{vv~}{ll}" format.name$ * 
            }
          if$
        }
      if$
      field.used editor.field = {", Eds" *} {} if$
    }
    {
        name.list #1 "{vv~}{ll}" format.name$
        field.used editor.field = {", Ed" *} {} if$
    }
  if$
}

FUNCTION {format.lab.names.full}
{ 'name.list :=
  #1 'nameptr :=
  name.list num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { name.list nameptr "{vv~}{ll}" format.name$ 'temp :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * temp * }
            { ", " * temp * }
            %{ %temp "others" =
               %{ " and~Coauthors." * }
                %{ " and " * temp * }
              %if$
            %}
          if$
             }
        'temp
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  numnames #1 > field.used editor.field = and {", eds" *} {} if$
  numnames #1 = field.used editor.field = and {", ed" *} {} if$
}

STRINGS { prev.author prev.author.bsame}

FUNCTION {make.list.label}
{ %author top$
    author.field field.used =
    { prev.author author compare.names format.authors
         author 'prev.author :=}
    { editor.field field.used =
        { prev.author editor compare.names format.editors
                editor 'prev.author := }
        { organization.field field.used =
            { "The " #4 organization chop.word
                duplicate$ prev.author = {pop$ "\bysame{}"}
                                         {duplicate$ 'prev.author :=} if$}
            { "foo" 'prev.author :=
              title.field field.used =
                { format.btitle }
                { key.field field.used =
                    { key #3 text.prefix$ }
                    { "Internal error :001 on " cite$ * " label" * warning$ }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
}

FUNCTION {count.bsame}
{   's :=
    'temp :=
    temp num.names$ 'len1 :=
    s num.names$ 'len2 :=
    #0 'bsnum :=
% len1 := min(len1,len2)
    len1 len2 > {len2 'len1 :=} {} if$
% start with an empty string, then while the components are the same
% add "\bysame"
    #1 'i :=
    {i len1 > not}
    { temp i "{ff }{vv }{ll}{ jj}" format.name$
% duplicate$ i int.to.str$ * warning$
      s i "{ff }{vv }{ll}{ jj}" format.name$
% duplicate$ i int.to.str$ * warning$
      =
        { %#1 i < {" and " *} {} if$
          bsnum #1 + 'bsnum :=
           i #1 + 'i :=}
        {#-1 'len1 :=}
        if$
      }
    while$
    
% add the rest of the second string
%    {i len2 > not}
%    { #1 i < {" and " *} {} if$
%      s i "{ff }{vv }{ll}{ jj}" format.name$ *
%      i #1 + 'i :=
%      }
%    while$
%bsnum int.to.chr$ *
% duplicate$ warning$
}


FUNCTION {format.bsnum.key}
{  'temp :=
    "{vv~}{ll}{jj}{f.}" "" "{vv~}{ll}{jj}{f.}" "" temp		%"{f.~}{vv~}{ll}{, jj}" "" temp
                count.bsame
     }

FUNCTION {make.list.label.key}
{ "abcxyz" 'prev.author :=
  %prev.author.bsame author count.bsame
  %bsnum #3 >
 % 	{#3 'bsnum :=}
%	{}
 % if$
 % author 'prev.author.bsame :=
  author.field field.used =
    {prev.author author compare.names format.authors.key
         author 'prev.author :=
         %author 'prev.author.bsame :=
         }
    { editor.field field.used =
        { prev.author editor compare.names format.editors
                editor 'prev.author := }
        { organization.field field.used =
            { "The " #4 organization chop.word
                duplicate$ prev.author = {pop$ "\bysame{}"}
                                         {duplicate$ 'prev.author :=} if$}
            { "foo" 'prev.author :=
              title.field field.used =
                { format.btitle }
                { key.field field.used =
                    { key #3 text.prefix$ }
                    { "Internal error :001 on " cite$ * " label" * warning$ }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
}


FUNCTION {make.full.label}
{ author.field field.used =
    { author format.authors.key }
    { editor.field field.used =
        { editor format.lab.names.full }
        { organization.field field.used =
            { "The " #4 organization chop.word #3 text.prefix$ }
            { title.field field.used =
                { format.btitle }
                { key.field field.used =
                    { key #3 text.prefix$ }
                    { "Internal error :001 on " cite$ * " label" * warning$ }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
}

FUNCTION {make.abbr.label}
{ author.field field.used =
    { author format.lab.names.abbr }
    { editor.field field.used =
        { editor format.lab.names.abbr }
        { organization.field field.used =
            { "The " #4 organization chop.word #3 text.prefix$ }
            { title.field field.used =
                { format.btitle }
                { key.field field.used =
                    { key #3 text.prefix$ }
                    { "Internal error :001 on " cite$ * " label" * warning$ }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\harvarditem[" write$
  make.abbr.label write$
  "]{" write$
  make.full.label write$
  "}{" write$
  newlabel write$
  "}{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  empty 'separator :=
  plain 'attribute :=
% }
%
%  FUNCTION {list.label.output}
% {
  space make.list.label plain comma output.nonnull
 
  }

FUNCTION {author.item.check} {author "author" item.check}

FUNCTION {format.title.if.not.sortkey.check}
{title.field field.used =
    {}
    { format.title "title" output.check }
  if$}
  
  
FUNCTION {write.url}
{ url empty$
    { skip$ }
    { "\urlprefix\url{" url * "}\urlsuffix" * write$ newline$ }
  if$
}

FUNCTION {check.ams.journal}
{journal "Bull. Amer. Meteor. Soc." =
 journal "Earth Interact." =
 or
 journal "J. Appl. Meteor. Climatol." =
 or
 journal "J. Atmos. Oceanic Technol." =
 or
 journal "J. Climate" =
 or 
 journal "J. Hydrometeor." = 
 or
 journal "J. Phys. Oceanogr." =
 or
 journal "J. Atmos. Sci." =
 or 
 journal "Mon. Wea. Rev." =
 or
 journal "Wea. Forecasting" =
 or
 journal "Wea. Climate Soc." =
 or
 {#1 'isams :=}
 {#0 'isams :=}
 if$
 }

FUNCTION {article}
{ check.ams.journal
  output.bibitem
  author.item.check
  output.month.year
 % output.extralabel
  format.title.if.not.sortkey.check
  crossref missing$
    { space journal italic comma "journal" output.check
      output.vol.num.pages.doi
    }
    { space format.article.crossref plain.space output.nonnull
      comma format.pages plain.comma.output
    }
  if$
  fin.article
  write.doi
}

FUNCTION {book}
{ output.bibitem
    author empty$
    { editor "author and editor" item.check }
    { crossref missing$
        { "author and editor" editor either.or.check }
        {}
      if$
    }
  if$
  output.month.year
  title.field field.used =
    {}
    { colon title italic space "title" output.check }
  if$
  crossref missing$
    { 
      space format.number.series plain.space.output
      format.edition.output
      format.bvolume.output
      format.publisher.address
      comma format.pages plain.space.output
    }
    { space format.book.crossref plain.space output.nonnull
      format.edition.output
    }
  if$
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  output.month.year
  format.title.if.not.sortkey.check
  space howpublished plain.space.output
  space address plain.space.output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
    author empty$
    { editor "author and editor" item.check }
    { crossref missing$
        { "author and editor" editor either.or.check }
        {}
      if$
    }
  if$
  output.month.year
  title.field field.used =
    {}
    { space title italic space "title" output.check }
  if$
  crossref missing$
    { space format.number.series plain.space.output
      format.edition.output
      comma format.bvolume plain.comma output
      format.publisher.address
    }
    { space format.book.crossref plain.space output.nonnull
      format.edition.output
    }
  if$
  format.chapter.pages "chapter and pages" output.check
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  author.item.check
  output.month.year
  format.title.if.not.sortkey.check
  crossref missing$
    { output.in.ed.booktitle
      format.edition.output
      comma format.bvolume plain.space.output
      space format.number.series plain.space.output
      format.publisher.address
    }
    { output.incoll.inproc.crossref }
  if$
  space format.chapter.pages plain.space.output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  author.item.check
  output.month.year
  format.title.if.not.sortkey.check
  crossref missing$
    { output.in.ed.booktitle
      format.bvolume.output
      space format.number.series plain.space.output
      address empty$
        { comma organization plain.space.output
          % space publisher plain.space output.nonnull
        }
        { comma address plain.comma.output
          space organization plain.comma.output
          space publisher plain.comma.output
        }
      if$
    }
    { output.incoll.inproc.crossref}
  if$
  space format.pages plain.space.output
  fin.entry
  write.url
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
    output.month.year
    title.field field.used =
    {}
    {author empty$ {comma}{space} if$ title plain space "title" output.check }
  if$
  organization.field field.used = organization empty$ or
        {} {space organization plain.space output.nonnull} if$
  format.edition.output
  format.publisher.address
  fin.entry
  write.url
}

FUNCTION {mastersthesis}
{ output.bibitem
  author.item.check
  output.month.year
  format.title.if.not.sortkey.check
  space "Master's thesis" format.thesis.type plain.space output.nonnull
  comma school plain.space "school" output.check
  comma address plain.space.output
  fin.entry
  write.url
}

FUNCTION {misc}
{ output.bibitem
  author.item.check
  output.month.year
  format.title.if.not.sortkey.check
  space howpublished plain.space.output
  fin.entry
  empty.misc.check
  write.url
}

FUNCTION {phdthesis}
{ output.bibitem
    author.item.check
    output.month.year
  title.field field.used =
    {}
    { space title plain period "title" output.check }
  if$
  space "PhD dissertation" format.thesis.type plain.space output.nonnull
  comma school plain.space "school" output.check
  comma address plain.space.output
  fin.entry
  write.url
}

FUNCTION {proceedings}
{ output.bibitem
    author.item.check
    output.month.year
    title.field field.used =
    {}
    { space title plain space "title" output.check }
  if$
  format.bvolume.output
  space format.number.series plain.space.output
  address empty$
    { editor empty$
        {}
        { space organization plain.space.output
        }
      if$
      space publisher plain.space.output
    }
    { editor empty$
        {}
        { space organization plain.space.output }
      if$
      space publisher plain.space.output
      space address plain.space output.nonnull
    }
    if$
  fin.entry
  write.url
}

FUNCTION {techreport}
{ output.bibitem
  author.item.check
  output.month.year
  format.title.if.not.sortkey.check
  institution empty$
    {}
    { comma institution plain.space "institution" output.check }
    if$
  space format.tr.number.pages plain.space output.nonnull
  fin.entry
  write.url
}

FUNCTION {unpublished}
{ output.bibitem
    author.item.check
    output.month.year
  format.title.if.not.sortkey.check
  note "note" item.check
  fin.entry
  write.url
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

READ

EXECUTE {init.field.constants}

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { title empty$
            { key.field 'field.used := }
            { title.field 'field.used := }
          if$
        }
        { editor.field 'field.used := }
      if$
    }
    { author.field 'field.used := }
  if$
}

FUNCTION {key.organization.label}
 {organization empty$
        { title empty$
            { key.field 'field.used := }
            { title.field 'field.used := }
          if$
        }
        { organization.field 'field.used := }
        if$}

FUNCTION {author.key.organization.label}
{ author empty$
    { key.organization.label}
    { author.field 'field.used := }
    if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { key.organization.label}
    { editor.field 'field.used := }
  if$
}

FUNCTION {sort.format.title}
{ 'temp :=
  "A " #2
    "An " #3
      "The " #4 temp chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
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
            'author.editor.key.label    % don't really use .editor.
          if$
        }
      if$
    }
  if$
  make.full.label
  %title.field field.used =
   % { sort.format.title }
    %{ sortify }
  %if$
  " " 
  *
  year field.or.null sortify
  *
  'sort.label :=
  %sort.label top$
  
}

FUNCTION {first.presort}
{ "abcxyz" 'prev.author :=
  calc.label
  " " sort.label * 
  "    "
  *
  title.field field.used =
    {}
    { "    "
      *
      title field.or.null
      sort.format.title
      *
    }
  if$
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {first.presort}

FUNCTION {print.sort.keys} {sort.key$ top$}
FUNCTION {gibberish.bsame} {"abcxyz" 'prev.author.bsame :=}

SORT

FUNCTION {bf.2sort} {"AFTER FIRST PRESORT:" top$}
%EXECUTE {bf.2sort}
%ITERATE {print.sort.keys}

STRINGS { last.label next.extra }
INTEGERS { last.extra.num number.label }
FUNCTION {initialize.extra.label.stuff}
{ #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'last.extra.num :=
  #0 'number.label :=
}
FUNCTION {forward.pass}
{  last.label sort.label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      sort.label 'last.label :=
    }
  if$
  number.label #1 + 'number.label :=

}
FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ empty$
    'skip$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
  extra.label 'temp.extra := 
  sort.label extra.label * 'sort.label :=
  year temp.extra * 'newlabel :=
}
EXECUTE {initialize.extra.label.stuff}

ITERATE {forward.pass}

REVERSE {reverse.pass}


FUNCTION {second.presort}
{ make.list.label.key
   "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title.field field.used =
    { sort.format.title }
    { sortify }
  if$
  "    "
  *
  short.list field.or.null sortify
  *
  "    "
  *
  title.field field.used =
    {}
    { title field.or.null
      sort.format.title
      *
    }
  if$
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {second.presort}


FUNCTION {third.presort}
{bsnum 'old.bsnum :=
make.list.label.key
bsnum old.bsnum  >
{  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title.field field.used =
    { sort.format.title }
    { sortify }
  if$
  "    "
  *
  short.list field.or.null sortify
  *
  "    "
  *
  title.field field.used =
    {}
    { title field.or.null
      sort.format.title
      *
    }
  if$
  #1 entry.max$ substring$
  'sort.key$ :=
  }
  {pop$}
  if$

author 'prev.author.bsame :=
}


EXECUTE{gibberish.bsame}

REVERSE{third.presort}

SORT


%INTEGERS { number.label }

FUNCTION {initialize.longest.label}
{
  #1 'number.label :=
  "abcxyz" 'prev.author :=
}

FUNCTION {longest.label.pass}
{ 
     %"" 'extra.label :=
    author empty$ { editor empty$ {"foo"} {editor} if$}
                  {author}
                   if$
    'f :=
% remember this entry to compare to the next one
    author empty$ { editor empty$ {"abcxyz"} {editor} if$} {author} if$
        'prev.author := 
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    {}
    { preamble$ write$ newline$ }
  if$
  "\ifx\undefined\bysame" write$ newline$
  %"\newcommand{\bysame}{\leavevmode\hbox to\leftmargin{\hrulefill\,\,}}"
  "\newcommand{\bysame}{---{}---}"
    write$ newline$
  "\fi" write$ newline$
  "\begin{thebibliography}{xx}" 
  write$ newline$
 "\providecommand{\natexlab}[1]{#1}"
  write$ newline$
  "\providecommand{\url}[1]{\texttt{#1}}"
  write$ newline$
 "\renewcommand{\UrlFont}{\rmfamily}"
  write$ newline$
  "\providecommand{\urlprefix}{[Available online at }"
  write$ newline$
  "\providecommand{\urlsuffix}{.]}"
  write$ newline$
  %"\expandafter\ifx\csname urlstyle\endcsname\relax"
  %write$ newline$
   "\providecommand{\doiprefix}{doi:}"
  write$ newline$
  "\providecommand{\doisuffix}{.}"
  write$ newline$

}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

FUNCTION {init.call}
 { "abcxyz" 'prev.author := }

EXECUTE {init.call}

ITERATE {call.type$}

FUNCTION {end.bib}
        {newline$ "\end{thebibliography}" write$ newline$ }

EXECUTE {end.bib}
