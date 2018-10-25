
#!/bin/sh

cat DataCite-access.log-*-* > DataCite-access.log-201805
echo 'Logs have been merged' 
echo 'Sorting started ...' 
sort -k3 DataCite-access.log-201805 > DataCite-access.log-201805-sorted 
echo 'Logs have been sorted' 
echo 'Labeling started ...' 
# sed -i '1s/^/BEGIN  \n/' DataCite-access.log-201805-sorted 
# sed -e '$a\EOF\' DataCite-access.log-201805-sorted 
echo 'Completed' 
