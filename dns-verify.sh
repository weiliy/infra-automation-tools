#/bin/bash
# Verify DNS record

# Variable
DNSFILE=$1
TEMPDIR=/tmp

#

while read FQDN IP ; do
    RS=$(nslookup $FQDN | grep -v '#' | grep Address | cut -d' ' -f2)
    if [ "$IP" = "$RS" ] ; then
        FQDNtoIP="Success!"
    else
        FQDNtoIP="Failed!:[Incorrect in DNS:$RS]"
    fi
    RS=$(nslookup $IP | grep "name =" | awk '{print substr($4,0,(length($4)-1))}')
    if [ "$FQDN" = "$RS" ] ; then
        IPtoFQDN="Success!"
    else
        IPtoFQDN="Failed![Incorrect in DNS:$RS]"
    fi
    echo "[$FQDN] -> [$IP] : $FQDNtoIP"
    echo "[$IP] -> [$FQDN] : $IPtoFQDN"
done < $DNSFILE
