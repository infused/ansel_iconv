# ANSEL::Iconv

ANSEL::Iconv is a wrapper for Iconv that adds ANSEL character set conversion to
any other encoding supported by Iconv.

Copyright (c) 2006-2009 Keith Morrison <mailto:keithm@infused.org>, <http://www.infused.org>

* Project page: <http://github.com/infused/ansel_iconv>
* Report bugs: <http://github.com/infused/ansel_iconv/issues>
* Questions? Email [keithm@infused.org](mailto:keithm@infused.org?subject=ANSEL::Iconv)
  with ANSEL::Iconv in the subject line

## Installation

    gem install infused-ansel_iconv --source http://gems.github.com
    
## Basic Usage
    
    require 'ansel_iconv'
    
    # Convert ANSEL to UTF-8
    @ansel = ANSEL::Iconv.new 'UTF-8'
    @ansel.iconv("\xB9\x004.59") # => "£4.59" 
  
## About the ANSEL character set

ANSI/NISO Z39.47 also known as ANSEL is a character set encoding used 
primarily for bibliographic and genealogical data. More information can be found at the
[Official NISO standard](http://www.niso.org/kst/reports/standards?step=2&gid%3Austring%3Aiso-8859-1=&project_key%3Austring%3Aiso-8859-1=0b5d2bd7b690b60fcc75cde9256ed9f9e526e531)
page.

## LICENSE:

(The MIT License)

Copyright (c) 2006-2009 Keith Morrison <mailto:keithm@infused.org>, <http://www.infused.org>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
