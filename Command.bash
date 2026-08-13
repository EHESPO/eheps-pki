# Clone the repository
git clone https://github.com/EHEPS-International/eheps-pki.git
cd eheps-pki

# Install dependencies
make install

# Test everything
make test

# Install as GitHub CLI extension locally
gh extension install .

# Generate your first certificate
./scripts/generate-csr.sh --type tls --domain eheps.com

# Verify the chain
./scripts/verify-chain.sh certificates/eheps.com.crt

# Deploy to GitHub Secrets
./scripts/deploy-github-secrets.sh

# Push to GitHub
git add .
git commit -m "Initial EHEPS PKI implementation"
git push origin main

# Enable GitHub Actions
gh repo edit EHEPS-International/eheps-pki --enable-actions
