AVENOIR CODEBASE REPOSITORY GUIDELINES

This document aims to provide guidelines for maintaining as well as accessing the blog repository of Avenoir Technologies Pvt Ltd.

The code maintains proper description blocks, ticket naming conventions, and branch naming conventions, as well as coding guidelines to help the end user find the content easily.

The code commitment for the section has been committed and developed under the following guidelines mentioned

Tickets

The ticket mentioned in the description block will help to search the details of the blog in JIRA.

The ticket maintains different branches for each different section i.e. client interview question, training question, jd interview question, and blog and contents must fall under the respective branches.

The ticket mentions the environment (scratch org credentials). After the development is done, the ticket gets updated with the pull request, blog draft, and scratch org details.

The code contains proper description blocks, ticket naming conventions, and branch naming conventions so as to easily get through the respective content and its Author details.

BLOG

File naming convention -

To search the blog code the user may press - (ctrl + shift + F) and do a search on the blog title, all respective code files will appear on the result.

The name of the main file has been the same as the name of the blog.

The naming convention for the file must be Upper camelCased in case of all.

Domain and Service classes are named in the following manner: Example: ObjectName_Domain, e.g. ProjectRole_Domain.

Description Block

/***********************************************************************

(c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
Created by: Creator Name
Ticket Number:
Blog: Send Emails to Queue Members.
Version History:
VERSION DEVELOPER NAME  DATE       DETAIL FEATURES 
1.0     Divya khare     11/10/2018 Initial Development 
1.1     Diksha Dewangan 03/10/2022 Created sObject record 
***********************************************************************/
