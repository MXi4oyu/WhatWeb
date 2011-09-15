##
# This file is part of WhatWeb and may be subject to
# redistribution and commercial restrictions. Please see the WhatWeb
# web site for more information on licensing and terms of use.
# http://www.morningstarsecurity.com/research/whatweb
##
# Version 0.2
# convert :regexp to :text, remove :certainty=>100
##
# Version 0.3
# added more matches for 1999- 2007 version, improved existing matches
##
# Version 0.4 # 2011-09-15 # Brendan Coles <bcoles@gmail.com>
# Minor match updates
# Added version detection
# Added matches for favicon, redirect page and headers
##
Plugin.define "Plesk" do
author "Andrew Horton"
version "0.4"
description "Plesk is a web control panel - Homepage: http://www.parallels.com/products/plesk/"

# Google results as at 2011-09-15 #
# 258 for intitle:"Default Parallels Plesk Panel Page"
#  16 for inurl:"plesk/unilogin.php"

# ShodanHQ results as at 2011-09-15 #
# 25,941 for PleskWin
#  1,881 for PleskLin
#    26 for sw-cp-server

# Dorks #
dorks [
'intitle:"Default Parallels Plesk Panel Page"'
]

# Examples #
examples %w|
193.92.33.194
178.63.88.4
63.141.138.20
188.40.159.225
173.193.22.105
50.22.88.100
213.142.141.191
216.28.245.171
212.174.225.246
85.214.39.102
80.237.244.17
|

# 2006
# <img src='def_plesk_logo.gif' alt="Plesk logo">
# <h1>This is the Plesk&#153; default page</h1>
# <p>For more information please contact <!--@adminemail@-->

# newer
# img/common/def_plesk_logo.gif
# <p>For more information please contact <!--@adminemail@-->

# 192.47.116.250
# <a target="_blank" href="http://www.parallels.com"><img src="img/common/parallels_powered.gif" title="Powered by Parallels&trade;"></a>


# http://202.89.57.34
# 1999-2006 version
# <title>Default PLESK Page</title>
# <img src='def_plesk_logo.gif' alt="Plesk logo" width="161" height="41">
#  <h1>This is the Plesk&#153; default page</h1>


# http://119.47.118.185/
# -2009 version
# <title>Default Parallels Plesk Panel Page</title>
# <h1><a class="product-logo" href="http://www.parallels.com/plesk/" title="Parallels Plesk Panel">Parallels Plesk Panel</a></h1>
# &copy; Copyright 1999-2009, Parallels<br />
# <p><strong>This page is generated by <a href="http://www.parallels.com/plesk/">Parallels Plesk Panel</a>
# This page was generated by <a href="http://www.parallels.com/en/products/plesk/">Parallels Plesk Panel</a>

# 1999- 2007 version
# This page is autogenerated by <a target="_blank" href="http://www.swsoft.com/en/products/plesk/">Plesk
# <div class="poweredBy"><a target="_blank" href="http://www.swsoft.com/en/products/plesk/"><img src="img/common/pb_plesk.gif"
# if (window.plesk_promo.virtuozzo) {

# Matches #
matches [

# /favicon.ico
{ :url=>"favicon.ico", :md5=>"2cee5e3ce2f5c4640a68fc208c286494" },

# X-Powered-By: PleskLin # X-Powered-By: PleskWin
{ :search=>"headers[x-powered-by]", :string=>/Plesk([WL]in)/ },

# HTTP Server Header
{ :certainty=>75, :search=>"headers[server]", :regexp=>/sw-cp-server/ },

# Logo HTML
{:name=>"logo gif", :regexp=>/<img src='def_plesk_logo\.gif' alt="Plesk logo"/ },

# HTML Comment
{:text=>'<p>For more information please contact <!--@adminemail@-->' },

# Powered by
{:name=>"poweredBy parallels", 
:regexp=>/<a target="_blank" href="http:\/\/www\.parallels\.com"><img src="[^"]+\/parallels_powered\.gif" title="Powered by Parallels&trade;"><\/a>/ }, #"
{:text=>'<div class="poweredBy"><a target="_blank" href="http://www.swsoft.com/en/products/plesk/'},

# Title
{:text=>'<title>Default PLESK Page</title>' },
{:text=>'<title>Default Parallels Plesk Panel Page</title>' },

# Heading
{:text=>'<h1>This is the Plesk&#153; default page</h1>' },
{:name=>"h1 plesk link", 
:text=>'<h1><a class="product-logo" href="http://www.parallels.com/plesk/" title="Parallels Plesk Panel">Parallels Plesk Panel</a></h1>' },

# Copyright
{:name=>"copyright parallels", :certainty=>25, :regexp=>/&copy; Copyright [\d]{4}\-[\d]{4}, Parallels</ },

# This page generated by plesk
{:regexp=>/This page (was|is) generated by <a href="http:\/\/www\.parallels\.com\/(en\/products\/)?plesk\/">Parallels Plesk Panel<\/a>/ },
{:text=>'This page is autogenerated by <a target="_blank" href="http://www.swsoft.com/en/products/plesk/">Plesk'},

# JavaScript
{ :certainty=>25, :text=>'if (window.plesk_promo.virtuozzo) {' },

# Redirect Page # HTML Comment
{ :url=>"/", :text=>'</html><!--______________________________________________________________________________________________________________________________________________________________________________________________________________________________________________IE error page size limitation______________________________________________________________________________________________________________________________________________________________________________________________________________________________________________-->' },

# Redirect Page # Version Detection # JavaScript
{ :url=>"/", :version=>/<script language="javascript" type="text\/javascript" src="\/javascript\/common\.js\?plesk_version=psa-([^\s^"]+)"\/?>/ },

]

end

