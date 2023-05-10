#!/bin/bash

# Define the HTML content
INDEX_HTML_CONTENT="<!DOCTYPE html>
<html>
<head>
	<title>System Usage</title>
</head>
<body>
	<h1>System Usage</h1>
	<ul>
		<li><a href=\"cpu.html\">CPU Usage</a></li>
		<li><a href=\"memory.html\">Memory Usage</a></li>
		<li><a href=\"disk.html\">Disk Usage</a></li>
	</ul>
</body>
</html>"

# Save the HTML content to a file
echo "$INDEX_HTML_CONTENT" > index.html
