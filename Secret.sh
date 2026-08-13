#!/bin/bash
# Deploy certificates as GitHub secrets

set -euo pipefail

REPO="${1:-${GITHUB_REPOSITORY:-EHEPS-International/eheps-pki}}"
CERT_FILE="${2:-certificates/eheps.com.crt}"

if [[ ! -f "$CERT_FILE" ]]; then
    echo "❌ Certificate file not found: $CERT_FILE"
    exit 1
fi

echo "📦 Deploying certificate to GitHub secrets..."

# Encode certificate
CERT_B64=$(cat "$CERT_FILE" | base64 -w0)

# Set secret using gh CLI
if command -v gh &> /dev/null; then
    echo "$CERT_B64" | gh secret set EHEPS_TLS_CERT --repo "$REPO" --body -
    echo "✅ Certificate deployed as GitHub secret: EHEPS_TLS_CERT"
else
    echo "⚠️  gh CLI not found. Install it first: https://cli.github.com/"
    echo "   Or manually set the secret:"
    echo "   gh secret set EHEPS_TLS_CERT --repo $REPO --body \"$CERT_B64\""
    exit 1
fi

# Deploy chain
if [[ -f "issuing/public-ca.crt" ]]; then
    CHAIN_B64=$(cat issuing/public-ca.crt | base64 -w0)
    echo "$CHAIN_B64" | gh secret set EHEPS_CHAIN_CA --repo "$REPO" --body -
    echo "✅ CA chain deployed as GitHub secret: EHEPS_CHAIN_CA"
fi
