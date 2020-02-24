package path;
 
# Versions (for download links)
our $version_asyncweb = "2.0.0-SNAPSHOT";
our $version_mina_2_0 = "2.0.21";
our $version_mina_2_1 = "2.1.3";
our $version_ftpserver = "1.1.1";
our $version_sshd = "2.1.0";
our $version_vysper = "0.7";

# All our pages use the same view function
our @patterns = (
    # Basic HTML content
    [qr!^/.*\.html$!, template_page => {} ],
    
    #
    # MINA sub-project pages
    #
    
    # Download MINA Archive page
    [qr!mina-project\/download\/download-archive\.mdtext$!, template_page => {
        template => "mina-project/download-archive.html",
        isMina => true, 
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1 } ],
    
    # Download MINA Linux BIN page
    [qr!mina-project\/download\/download-linux-bin\.mdtext$!, template_page => {
        template => "mina-project/download-linux-bin.html",
        isMina => true, 
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1 } ],
    
    # Download MINA Linux DEB page
    [qr!mina-project\/download\/download-linux-deb\.mdtext$!, template_page => {
        template => "mina-project/download-linux-deb.html",
        isMina => true, 
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1 } ],
    
    # Download MINA Linux RPM page
    [qr!mina-project\/download\/download-linux-rpm\.mdtext$!, template_page => {
        template => "mina-project/download-linux-rpm.html",
        isMina => true, 
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1 } ],
    
    # Download MINA Mac OS X page
    [qr!mina-project\/download\/download-macosx\.mdtext$!, template_page => {
        template => "mina-project/download-macosx.html",
        isMina => true, 
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1 } ],
    
    # Download MINA Sources page
    [qr!mina-project\/download\/download-sources\.mdtext$!, template_page => {
        template => "mina-project/download-sources.html",
        isMina => true, 
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1 } ],
    
    # Download MINA Windows page
    [qr!mina-project\/download\/download-windows\.mdtext$!, template_page => {
        template => "mina-project/download-windows.html",
        isMina => true, 
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1 } ],

    # MINA page with news
    [qr!mina-project\/index\.mdtext$!, template_page => {
        template => "mina-project/index.html",
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1,
        isMina => true } ],
    
    # Standard MINA page
    [qr!mina-project\/.*?\.mdtext$!, template_page => {
        template => "page.html",
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1,
        isMina => true } ],
    
    #
    # Apache FtpServer sub-project pages
    #
    
    # Download Apache FtpServer Archive page
    [qr!ftpserver-project\/download\/download-archive\.mdtext$!, template_page => {
        template => "ftpserver-project/download-archive.html",
        isFtpServer => true, 
        version_ftpserver => $version_ftpserver } ],
    
    # Download Apache FtpServer Sources page
    [qr!ftpserver-project\/download\/download-sources\.mdtext$!, template_page => {
        templatapie => "ftpserver-project/download-sources.html",
        isFtpServer => true, 
        version_ftpserver => $version_ftpserver } ],
    
    # Standard Apache FtpServer page
    [qr!ftpserver-project\/.*?\.mdtext$!, template_page => {
        template => "ftpserver-project/page.html",
        version_ftpserver => $version_ftpserver,
        isFtpServer => true } ],

    #
    # Apache Sshd sub-project pages
    #

    # Download Apache Sshd Archive page
    [qr!sshd-project\/download\/download-archive\.mdtext$!, template_page => {
        template => "sshd-project/download-archive.html",
        isSshd => true,
        version_sshd => $version_sshd } ],

    # Download Apache Sshd Sources page
    [qr!sshd-project\/download\/download-sources\.mdtext$!, template_page => {
        templatapie => "sshd-project/download-sources.html",
        isSshd => true,
        version_sshd => $version_sshd } ],
   
    # Standard Apache Sshd page
    [qr!sshd-project\/.*?\.mdtext$!, template_page => {
        template => "sshd-project/page.html",
        version_sshd => $version_sshd,
        isSshd => true } ],

    #
    # Apache Vysper sub-project pages
    #

    # Download Apache Vysper Archive page
    [qr!vysper-project\/download\/download-archive\.mdtext$!, template_page => {
        template => "vysper-project/download-archive.html",
        isVysper => true,
        version_vysper => $version_vysper } ],

    # Download Apache Vysper Sources page
    [qr!vysper-project\/download\/download-sources\.mdtext$!, template_page => {
        templatapie => "vysper-project/download-sources.html",
        isVysper => true,
        version_vysper => $version_vysper } ],
   
    # Standard Apache Vysper page
    [qr!vysper-project\/.*?\.mdtext$!, template_page => {
        template => "vysper-project/page.html",
        version_vysper => $version_vysper,
        isVysper => true } ],
   
    #
    # Apache AsyncWeb sub-project pages
    #

    # Download Apache AsyncWeb Archive page
    [qr!asyncweb-project\/download\/download-archive\.mdtext$!, template_page => {
        template => "asyncweb-project/download-archive.html",
        isAsyncweb => true,
        version_asyncweb => $version_asyncweb } ],

    # Download Apache Asyncweb Sources page
    [qr!asyncweb-project\/download\/download-sources\.mdtext$!, template_page => {
        templatapie => "asyncweb-project/download-sources.html",
        isAsyncweb => true,
        version_asyncweb => $version_asyncweb } ],

    # Standard Apache Asyncweb page
    [qr!asyncweb-project\/.*?\.mdtext$!, template_page => {
        template => "asyncweb-project/page.html",
        version_asyncweb => $version_asyncweb,
        isAsyncweb => true } ],
 
    #
    # Apache MINA project pages
    #
    [qr!^/.*\.mdtext$!, template_page => {
        template => "page.html",
        isSite => true,
        version_mina_2_0 => $version_mina_2_0,
        version_mina_2_1 => $version_mina_2_1,
        version_ftpserver => $version_ftpserver,
        version_asyncweb => $version_asyncweb,
        version_sshd => $version_sshd,
        version_vysper => $version_vysper} ]
);

# for specifying interdependencies between files
our %dependencies = ();

1;

=head1 LICENSE

           Licensed to the Apache Software Foundation (ASF) under one
           or more contributor license agreements.  See the NOTICE file
           distributed with this work for additional information
           regarding copyright ownership.  The ASF licenses this file
           to you under the Apache License, Version 2.0 (the
           "License"); you may not use this file except in compliance
           with the License.  You may obtain a copy of the License at

             http://www.apache.org/licenses/LICENSE-2.0

           Unless required by applicable law or agreed to in writing,
           software distributed under the License is distributed on an
           "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
           KIND, either express or implied.  See the License for the
           specific language governing permissions and limitations
           under the License.

