# GitHub Integration Guide

## 1. Installation as GitHub CLI Extension

```bash
# Install the extension
gh extension install EHEPS-International/eheps-pki

# Verify installation
gh eheps-pki --version
gh eheps-pki verify --cert certificates/eheps.com.crt
gh eheps-pki sign-commit --message "Signed with EHEPS PKI"
gh eheps-pki health-check --domain eheps.com

gh eheps-pki generate --type tls --domain eheps.com
