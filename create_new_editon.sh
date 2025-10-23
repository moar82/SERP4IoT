#!/bin/bash
###Author: Rodrigo Morales
##This script archives the current edition in a new folder name after the first parameter.
##It also updates the hyperlinks to work with the past edition.
## It 
##Example: ./create_new_editon.sh 2050
##			where 2050 is the year that you want to archive.  
##			the next step is to modify the index file in the root path, which would be the new year.

YEAR=$1

cd past_editions
##Do not forget to add an item in the file ./past_editions/index.html with the archived workshop 
sed -i 's|<ul>|<ul> \n <li><a href="https://moar82.github.io/SERP4IoT/past_editions/'$YEAR'/index.html">'$YEAR'</a></li>|g' index.html

mkdir $YEAR

 if [ -d "$YEAR" ] # if it's a directory
    then
        
		#copy the folders in the past edition directory.
		cp ../index.html ./$YEAR
		cp -r ../apapers ./$YEAR #accepted papers
		cp -r ../aprogram ./$YEAR #keynotes
		#cp -r ../attending ./$YEAR
		cp -r ../Committees ./$YEAR
		cp -r ../cpapers ./$YEAR
		cp -r ../program ./$YEAR
		cp -r ../sb ./$YEAR #submission guidelines
		#cp -r ../submissions ./$YEAR

		cd $YEAR
		find . -name "*.html" -print0 | xargs -0 sed -i 's/default/default'$YEAR' /g'
fi
		
		cd ../../_layouts

		touch default$YEAR.html

		cat > default$YEAR.html << _EOF_

		<!DOCTYPE html>
			<html>
				<head>
					<title>{{ page.title }}</title>
					<!-- link to main stylesheet -->
					<link rel="stylesheet" type="text/css" href="https://moar82.github.io/SERP4IoT/css/main.css">
				</head>
				<body>
					<nav>
						<ul>
						<li><a href="https://moar82.github.io/SERP4IoT/past_editions/$YEAR">Home</a></li>        		
						<li><a href="https://moar82.github.io/SERP4IoT/past_editions/$YEAR/cpapers">Call for papers</a></li>
					<li><a href="https://moar82.github.io/SERP4IoT/past_editions/$YEAR/sb">Submissions</a></li>
					<li><a href="https://moar82.github.io/SERP4IoT/past_editions/$YEAR/aprogram">Keynotes</a></li>
					<li><a href="https://moar82.github.io/SERP4IoT/past_editions/$YEAR/apapers">Accepted papers</a></li>
					<li><a href="https://moar82.github.io/SERP4IoT/past_editions/$YEAR/program">Program</a></li>
					<li><a href="https://moar82.github.io/SERP4IoT/past_editions/$YEAR/Committees">Committees</a></li>         
					<li><a href="https://moar82.github.io/SERP4IoT/">Current edition</a></li>
						</ul>
					</nav>
					<div class="container">
					
					{{ content }}
					
					</div><!-- /.container -->
					<footer>
						<ul>
							<li>Contact: serp4iot[at]gmail[dot]com</li>
						<li>Twitter: <a href=https://twitter.com/serp4iot target=_blank> @serp4iot </a> </li>
						</ul>
					</footer>
				</body>
			</html>

_EOF_
## Create an empty web page for keynotes with the legend TBA
		cd ../aprogram
		cat > index.html << _EOF_
---
layout: default
title: Keynotes
---

<h2>To be announced ...</h2>
_EOF_


## Create an empty web page for accepted papers with the legend TBA
		cd ../apapers
		cat > index.html << _EOF_
---
layout: default
title: Accepted papers
---

<h2>To be announced ...</h2>
_EOF_


## Create an empty web page for Program with the legend TBA
		cd ../program
		cat > index.html << _EOF_
---
layout: default
title: Workshop program
---

<h2>To be announced ...</h2>
_EOF_


echo Do not forget to update "call for papers" at /cpapers/index.html
echo 	"Submissions " /sb/index.html
echo and /index.html