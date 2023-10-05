#!/bin/bash
###Author: Rodirgo Morales
##This script archives the current edition in a new folder name after the first parameter.
##It also updates the hyperlinks to work with the past edition.
## It 
##Example: ./create_new_editon.sh 2050
##			where 2050 is the current year that you want to archive.  
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
		cp -r ../apapers ./$YEAR
		cp -r ../aprogram ./$YEAR
		cp -r ../attending ./$YEAR
		cp -r ../Committees ./$YEAR
		cp -r ../cpapers ./$YEAR
		cp -r ../program ./$YEAR
		cp -r ../sb ./$YEAR
		cp -r ../submissions ./$YEAR

		cd $YEAR
		find . -name "*.html" -print0 | xargs -0 sed -i 's/default/default'$YEAR' /g'
fi

		##TODO: Functionality to automatically create html file in SERP4IoT/_layouts
		
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
					<li><a href="https://moar82.github.io/SERP4IoT/past_editions/$YEAR/attending">Attending</a></li>
					<li><a href=https://moar82.github.io/SERP4IoT/>Current edition</a></li>
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