#!/bin/bash
###Author: Rodirgo Morales
#This script archives the current edition in a new folder name after the first parameter.
#It also updates the hyperlinks to work with the past edition

YEAR=$1

cd past_editions
mkdir $YEAR

 if [ -d "$YEAR" ] # if it's a directory
    then
        
		#copy the folders in the past edition directory.
		cp -r ../apapers ./$YEAR
		cp -r ../aprogram ./$YEAR
		cp -r ../attending ./$YEAR
		cp -r ../Committees ./$YEAR
		cp -r ../cpapers ./$YEAR
		cp -r ../idates ./$YEAR
		cp -r ../program ./$YEAR
		cp -r ../sb ./$YEAR
		cp -r ../submissions ./$YEAR

		cd $YEAR
		find . -name "*.html" -print0 | xargs -0 sed -i 's/default/default'$YEAR' /g'

		##TODO: Functionality to automatically create html file in SERP4IoT/_layouts
		cd ../../_layouts

		touch default$YEAR.html

		cat > default$YEAR.html << EOF

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
					<li><a href="https://moar82.github.io/SERP4IoT/past_editions/$YEAR/idates">Important dates</a></li>            
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


		EOF
fi
