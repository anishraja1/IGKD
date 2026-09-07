# Integrated Gene Knowledge Database (IGKD)

## Introduction

The inspiration for the Integrated Gene Knowledge Database (IGKD) is Chado. Chado is a community-driven, open-source relational database schema that is highly normalized and can be scaled to accommodate many different types of biological data. 

IGKD focuses on gene annotations and their association with Gene Ontology terms. Controlled vocabularies provide a standardized and consistent way to describe data, while ontologies define structured relationships between these terms. Gene annotations help provide meaningful information about gene products, including their molecular function, biological processes, and cellular components.

IGKD is designed to store, organize, and manage gene annotation data by linking gene products to Gene Ontology terms. The database also incorporates temporal information to track when gene annotations are created and updated, supporting data accuracy and reproducibility.

## Documentation

A detailed project report is included that describes the requirements, design, and implementation of the IGKD database. It covers the system and database requirements, conceptual and logical database design, Entity Relationship (ER) model and diagram, data dictionary, integrity and operational rules, and database operations.

The report also discusses database security, backup and recovery, development tools, advanced SQL features and queries, and the CRUD matrix.

## Features
- Query gene products associated with specific genetic diseases
- Compare gene-family distributions across organisms
- Identify biological pathways associated with disease-linked genes
- Retrieve annotations by organism, chromosome, and Gene Ontology category
- Identify missing gene product-ontology annotations
- Navigate parent-child relationships between Gene Ontology terms

## Technologies
- MySQL 8.0
- MySQL Workbench
