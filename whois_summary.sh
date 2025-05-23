#!/bin/bash

# Check for input
if [ -z "$1" ]; then
    echo "Usage: $0 domain.com"
    exit 1
fi

# Clean domain (remove www. if present)
DOMAIN=$(echo "$1" | sed 's/^www\.//')
BASENAME=$(echo "$DOMAIN" | cut -d '.' -f1)
FILENAME="${BASENAME}_report.txt"

# Run whois
WHOIS_OUTPUT=$(whois "$DOMAIN")

# Write summary
{
echo "WHOIS Summary Report for $DOMAIN"
echo "======================================"
echo "Domain Name:       $(echo "$WHOIS_OUTPUT" | grep -iE '^Domain Name:' | head -1)"
echo "Registrar:         $(echo "$WHOIS_OUTPUT" | grep -iE '^Registrar:|Sponsoring Registrar:' | head -1)"
echo "Creation Date:     $(echo "$WHOIS_OUTPUT" | grep -iE '^Creation Date:' | head -1)"
echo "Expiration Date:   $(echo "$WHOIS_OUTPUT" | grep -iE '^Registrar Registration Expiration Date:|^Expiration Date:' | head -1)"
echo "Updated Date:      $(echo "$WHOIS_OUTPUT" | grep -iE '^Updated Date:' | head -1)"
echo "Name Servers:"
echo "$WHOIS_OUTPUT" | grep -iE '^Name Server:'
echo "======================================"
} > "$FILENAME"

echo "WHOIS summary saved to $FILENAME"
