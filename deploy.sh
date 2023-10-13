#!/bin/sh
hexo generate
cp -R public/* /var/www/html/
