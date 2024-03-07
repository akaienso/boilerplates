<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title><cfoutput>#StoryQ.Headline#</cfoutput> | DACdb Story Share</title>
    <meta name="title" content="<cfoutput>#StoryQ.Headline#</cfoutput>">
    <meta name="description" content="<cfoutput>#encodeForHTML(StoryQ.Description)#</cfoutput>">

    <!-- Open Graph / Facebook -->  
    <!-- LinkedIn and other platforms would generally be covered by the OG tags. -->
    <meta property="og:type" content="article" />
    <meta property="og:url" content="https://www.ismyrotaryclub.org/Story/fb-share.cfm?StoryID=<cfoutput>#StoryID#</cfoutput>" />
    <meta property="og:title" content="<cfoutput>#encodeForHTML(StoryQ.Headline)#</cfoutput>" />
    <meta property="og:description" content="<cfoutput>#encodeForHTML(StoryQ.Description)#</cfoutput>" />
    <meta property="og:image" content="<cfoutput>#docURL##encodeForHTML(StoryQ.Image)#</cfoutput>" />

    <!-- Twitter -->
    <meta name="twitter:card" content="<cfoutput>#docURL##encodeForHTML(StoryQ.Image)#</cfoutput>">
    <meta name="twitter:site" content="@memberminderpro">
    <meta name="twitter:title" content="<cfoutput>#encodeForHTML(StoryQ.Headline)#</cfoutput>">
    <meta name="twitter:description" content="<cfoutput>#encodeForHTML(StoryQ.Description)#</cfoutput>">
    <meta name="twitter:image" content="<cfoutput>#docURL##encodeForHTML(StoryQ.Image)#</cfoutput>">

    <link rel="icon" href="/images/favicon.png" type="image/png">
    <link rel="stylesheet" href="/css/fb-share.css">
</head>
<body>

    <header>
        <!-- Navigation and site-wide header content can go here -->
    </header>
    <cfoutput>
    <main>
        <cfloop query="StoryQ">
        <article>
            <header>
                <h1 class="Headline">#Headline#</h1>
                <cfif bitStoryDate>
                    <p class="StoryDate">#DateFormat(StoryDate, "dddd, mmmm d, yyyy")#</p>
                </cfif>
                <cfif bitByLine>
                    <p class="ByLine">By #Submitted_By#</p>
                </cfif>
                <cfif bitEditedBy AND Created_By NEQ Modified_By>
                    <p class="ByLine">Edited By #Modified_By#</p>
                </cfif>
            </header>

            <cfif Len(Image) GT 0>
                <cftry>
                    <cfset storyImage = "#docRoot##Image#">
                    <cfset myImage=ImageNew(storyImage)>
                    <cfimage source="#myImage#" action="info" structName="picInfo">
                    <figure>
                        <img src="#docURL##Image#" alt="illustrative header image for #Headline#">
                        <figcaption>Image from "#Headline#"</figcaption>
                    </figure>
        
                    <cfcatch></cfcatch>	
                </cftry>
            </cfif>

            <section class="article-body">
                <cfif Len(Trim(Summary)) GT 0>
                    <div>#Summary#</div>
                </cfif>
                <div>#Description#</div>
            </section>
        </article>
        </cfloop>
    </main>

    <footer>
        <nav>
            <ul>
                <li><a href="/">Home</a></li>
                <li><a href="/privacy-policy">Privacy Policy</a></li>
                <li><a href="/terms-of-use">Terms of Use</a></li>
            </ul>
        </nav>
        <p>&copy; <span class="current-year">2022</span> <a href="https://yourcompany.url">Your Company or Your Name</a>. All rights reserved.</p>
    </footer>
</cfoutput>
<script>
    document.querySelectorAll('.current-year').forEach(function(element) {
        const startYear = parseInt(element.textContent, 10);
        const currentYear = new Date().getFullYear();
        if (currentYear > startYear) {
            element.textContent += ` – ${currentYear}`;
        }
        // If currentYear is equal to startYear or the script fails to run, the original text remains unchanged.
    });
</script>

</body>
</html>
