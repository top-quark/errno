# errno
A web service providing errno references for a number of operating systems either as an interactive web page or a JSON API. 

## Building
From the source directory, run:
<pre>$ make server=http://my.server.domain all</pre>

This will generate the webapp, `perl/errno`, and a zip file, `errno.zip` for you to unpack on your webserver. The archive
contains both the webapp and an image, `images/little_hal.jpg`. The HTML template, `errno.html` assumes that the image will be
installed into a directory called `/images` under your webroot. If this is not the case, edit the template and correct
the CSS.

### Details

The assembly script, `errnogen`, munges the JSON data files and the template files `errno.html` and `errno.pl.template` 
into a single script file, `errno`.

## Deploying

The built `errno` script can either run as a standalone CGI application or using `Apache::Registry`. Copy it to the relevant
directory (for example, `/var/www/cgi-bin` or `/var/www/perl`) and it should work without any additional configuration.
If you're not using Apache, then simply copy it into the CGI directory for your server.

## Using

The webapp has errno data for three operating systems, `linux`, `macosx` and `windows`. To view the info as an HTML 
page, navigate to `/path/to/errno/<os>`, for example `/path/to/errno/linux`. To view the info as JSON, add `json` to
the path, for example `/path/to/errno/linux/json`. To use it as a JSONP API, add a query string with a `callback` 
parameter, for example, `/path/to/errno/linux/json?callback=window.errorInfo`.

## Customizing

If you want to add errno information for another operating system, copy the `errno2json` script onto the target 
system and capture its output, for example:
<pre>/path/to/errno2json >openbsd.json</pre>
The script assumes a `gcc` compiler. If you use another compiler, you will need to hack the script. It shouldn't be
difficult: just find the bit that says `gcc -E` and convert it to the invocation that produces preprocessor output on your 
system.

`errno2json` requires the `JSON` Perl module to be installed.

Copy the json file into your source directory. Edit `errno.pl.template` to add the OS to the name map:
<pre>my %osNames = (
    linux => "Linux",
    macosx => "Mac OS X",
    windows => "Windows",
    freebsd => "FreeBSD",
    <b>openbsd => "OpenBSD"</b>
);
</pre>

Now simply rebuild. The new JSON file will be picked up automatically.

## Try It Out!
Point your browser at <a href="http://www.usefuljs.net/api/errno" target="_blank">my server</a>.

## Licencing
errno is licensed under the Apache 2.0 licence.
