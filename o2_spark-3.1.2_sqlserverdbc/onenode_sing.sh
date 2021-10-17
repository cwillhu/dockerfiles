
export MASTER="spark://$(hostname -f):7077"

#Launch application
spark-submit \
    --master yarn \
    --deploy-mode client \
    --principal=$PRINCIPAL \
    --keytab=$KEYTAB \
    readTable_docker.py
