# Procurement Supplier Concentration Analysis (2021)

## Overview
This project analyzes public procurement data to understand how contracts are distributed among suppliers within government agencies. The focus is on identifying supplier concentration and determining whether agencies rely heavily on a single supplier.

## Objective
The objective of this analysis is to:
- Calculate supplier share within each agency
- Identify the top supplier per agency
- Measure the level of supplier dominance
- Assess whether procurement is concentrated or distributed

## Dataset
The dataset is based on OCDS procurement data for 2021.  
It contains information on agencies (buyers), suppliers, and contract values.

## Data Cleaning
Some records contained blank supplier names (87 rows).  
These were excluded from the analysis to ensure accurate supplier-level insights.

## Methodology
1. Aggregated contract values per supplier within each agency  
2. Calculated total procurement value per agency  
3. Computed supplier share (supplier value ÷ agency total)  
4. Identified the maximum supplier share per agency  
5. Matched the maximum share to determine the top supplier  
6. Classified dominance levels:
   - High (> 60%)
   - Medium (30–60%)
   - Low (< 30%)

## Key Findings
- 25 agencies showed high supplier dominance  
- 16 agencies showed moderate dominance  
- 7 agencies showed low dominance  

This indicates that procurement is largely concentrated, with many agencies relying heavily on a single supplier.

However, supplier dominance is mostly agency-specific, as very few suppliers appear as top suppliers across multiple agencies.

## Conclusion
The analysis shows that while supplier dominance is significant within individual agencies, there is no strong evidence of system-wide supplier monopolies. This suggests localized concentration rather than centralized control across agencies.

## Tools Used
- MySQL  
- SQL
