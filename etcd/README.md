# Scripts

### dump_etcd_objs.sh

This is a simple script to print out the etcd object types along with their counts. 

An ideal usage would be to run the script monthly to track the growth of object types. Some growth is expected while others is not. 

Ex cronjobs with no success/failed history limits

#### Usage
~~~
./dump_etcd_objs.sh

#or to an output file

./dump_etcd_objs.sh > output.txt  2>&1 
~~~