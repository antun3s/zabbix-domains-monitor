#! /bin/bash

DOMAINS=/etc/domains-monitor/domains.txt
DOMAINS_FORMATADO=/tmp/domains-temp.txt
DOMAINS_FINAL=/tmp/domains-final.txt

# Insere inicio da estrutua
echo "{ \"data\": [ " > $DOMAINS_FORMATADO

# Lê cada linha do arquivo limpo e gera uma linha do arquido formatado
LINHAS=`wc -l $DOMAINS | awk '{print $1}'`
while IFS='' read -r line || [[ -n "$line" ]]; do
  if [ "$LINHAS" -gt 1 ]; then
      echo "{\"{#DOMAIN}\":\"$line\"}," >> $DOMAINS_FORMATADO
    else
      echo "{\"{#DOMAIN}\":\"$line\"}" >> $DOMAINS_FORMATADO
  fi
  let LINHAS--
done < "$DOMAINS"

# Insere final da estrutura
echo "] }" >> $DOMAINS_FORMATADO

# Junta todas as linha em apenas uma linha
cat $DOMAINS_FORMATADO | paste -sd "" - > $DOMAINS_FINAL

cat $DOMAINS_FINAL
