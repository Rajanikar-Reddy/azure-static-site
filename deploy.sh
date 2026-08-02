#!/bin/bash
set -e

RG_NAME="rg-staticsite"
STORAGE_NAME="staticsite$(date +%s | tail -c 7)"
LOCATION="northeurope"

echo "Creating resource group..."
az group create -n $RG_NAME -l $LOCATION

echo "Creating storage account..."
az storage account create -n $STORAGE_NAME -g $RG_NAME --sku Standard_LRS -l $LOCATION

echo "Enabling static website..."
az storage blob service-properties update --account-name $STORAGE_NAME \
  --static-website --index-document index.html

echo "Uploading files..."
az storage blob upload-batch -s . -d '$web' --account-name $STORAGE_NAME --pattern "*.html"

echo "✅ Done! Site is at:"
az storage account show -n $STORAGE_NAME -g $RG_NAME --query "primaryEndpoints.web" -o tsv