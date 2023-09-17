python ~/s/test11.py
find . -type f -name "*.md" -exec sed -i 's/publishedAt: "1970-01-01\(.*\)T[0-9:]\{8\}\+[^"]\+"/publishedAt: "2010-01-12"/' {} +
