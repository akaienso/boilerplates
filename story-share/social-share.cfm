<!--- ----------------------------------------------------------------------------------------------
	Copyright(c) Member Minder Pro, LLC.
	More.cfm - View MORE of the stories for an Account or Club

	Modifications
		02/15/2024	-	(TKIRBY) 	Tweaked Meta data for Facebook feed
		3/6/2024	-	(RMOORE)	Refactored for valid semantic HTML 
									and SEO/Accessibility best practices

	IF THIS FILE IS UPDATED - ALSO UPDATE:
		/Rotary/Story/More.cfm			
		/IsMyRotaryClub/Story/More.cfm	
----------------------------------------------------------------------------------------------- --->
<cftry>
    <cfsetting showdebugoutput		= "Yes">
    <cftry>
        <cfparam name="StoryID" 		default="0" 				type="Numeric">
        <cfparam name="Summary" 		default="1" 				type="Numeric">
        <cfparam name="BGC"				default="FFFFFF" 			type="String">
        <cfparam name="Just"			default="center" 			type="String">
        <cfcatch>
            Contact Support.
            <cfabort>
        </cfcatch>
    </cftry>
    <cfinvoke component="#APPLICATION.DIR#CFC\StoryDAO" method="View"  returnvariable="StoryQ">
        <cfinvokeargument name="StoryID"				Value="#StoryID#">
        <cfinvokeargument name="StoryStateIDs"			Value="3">
    </cfinvoke>
    <cfset AccountID = StoryQ.AccountID>
    <cfset docRoot = "#SESSION.accountBasePath##AccountID#\ezStory\#StoryID#\">
    <cfset docURL  = "#SESSION.ApplURL#Accounts/#AccountID#/ezStory/#StoryID#/">
    <cfset cacheBuster = CreateUUID()>
    <cfset styleURL = "css/social-share.css?v=" & cacheBuster>
    <cfset scriptURL = "js/social-share.js?v=" & cacheBuster>
    <cffunction name="toTitleCase" access="public" returntype="string" output="false">
        <cfargument name="text" type="string" required="true">
        <cfset var words = ListToArray(LCase(arguments.text), " ")>
        <cfset var result = ArrayNew(1)>
        <cfset var smallWordsList = "a,an,the,and,but,or,for,nor,on,at,to,from,by,with,in">
    
        <cfloop index="i" from="1" to="#ArrayLen(words)#">
            <cfset var word = words[i]>
            <!-- Determine if the word is a small word, but not the first or last in the title -->
            <cfset var isSmallWord = ListFindNoCase(smallWordsList, word) AND i NEQ 1 AND i NEQ ArrayLen(words)>
            
            <cfif isSmallWord>
                <!-- Directly append small word without capitalization -->
                <cfset ArrayAppend(result, word)>
            <cfelse>
                <!-- Capitalize the first letter of the word -->
                <cfif Len(word) GT 1>
                    <cfset ArrayAppend(result, UCase(Left(word, 1)) & Right(word, Len(word)-1))>
                <cfelse>
                    <!-- If the word is a single character, just capitalize it -->
                    <cfset ArrayAppend(result, UCase(word))>
                </cfif>
            </cfif>
        </cfloop>
    
        <cfreturn ArrayToList(result, " ")>
    </cffunction>
    
    <cftry>
        <cfset titleCaseHeadline = toTitleCase(StoryQ.Headline)>
        
        <cfcatch type="any">
            <!-- Output error message -->
            <cfdump var="#cfcatch#">
        </cfcatch>
    </cftry>
    
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <title><cfoutput>#titleCaseHeadline#</cfoutput> | DACdb Story Share</title>
        <meta name="title" content="<cfoutput>#titleCaseHeadline#</cfoutput>">
        <meta name="description" content="<cfoutput>#encodeForHTML(StoryQ.Description)#</cfoutput>">
    
        <!-- Open Graph / Facebook -->  
        <!-- LinkedIn and other platforms would generally be covered by the OG tags. -->
        <meta property="og:type" content="article" />
        <meta property="og:url" content="https://www.ismyrotaryclub.org/Story/social-share.cfm?StoryID=<cfoutput>#StoryID#</cfoutput>" />
        <meta property="og:title" content="<cfoutput>#encodeForHTML(titleCaseHeadline)#</cfoutput>" />
        <meta property="og:description" content="<cfoutput>#encodeForHTML(StoryQ.Description)#</cfoutput>" />
        <meta property="og:image" content="<cfoutput>#docURL##encodeForHTML(StoryQ.Image)#</cfoutput>" />
        <meta property="fb:app_id" content="966242223397117" /> <!-- Use FB's default app ID to prevent errors in FB's debugger -->
        
        <!-- Twitter -->
        <meta name="twitter:card" content="<cfoutput>#docURL##encodeForHTML(StoryQ.Image)#</cfoutput>">
        <meta name="twitter:site" content="@memberminderpro">
        <meta name="twitter:title" content="<cfoutput>#encodeForHTML(titleCaseHeadline)#</cfoutput>">
        <meta name="twitter:description" content="<cfoutput>#encodeForHTML(StoryQ.Description)#</cfoutput>">
        <meta name="twitter:image" content="<cfoutput>#docURL##encodeForHTML(StoryQ.Image)#</cfoutput>">
    
        <link rel="icon" href="/images/favicon.png" type="image/png">
    
        <link rel="stylesheet" href="<cfoutput>#styleURL#</cfoutput>">
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
                    <h3>#titleCaseHeadline#</h3>
                    <ul>
                     <cfif bitByLine>
                        <li class="author">By #Submitted_By#</li>
                     </cfif>
                     <cfif bitStoryDate>
                        <li class="StoryDate">Published #DateFormat(StoryDate, "dddd, mmmm d, yyyy")#</li>
                     </cfif>
                     <cfif bitEditedBy AND Created_By NEQ Modified_By>
                        <li class="editor">Edited By #Modified_By#</li>
                     </cfif>
                     </ul>
                </header>
    
                <cfif Len(Image) GT 0>
                    <cftry>
                        <cfset storyImage = "#docRoot##Image#">
                        <cfset myImage=ImageNew(storyImage)>
                        <cfimage source="#myImage#" action="info" structName="picInfo">
                        <figure>
                            <img src="#docURL##Image#" alt="Illustrative header image for `#titleCaseHeadline#`">
                            <figcaption>Image from "#titleCaseHeadline#"</figcaption>
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
            <p>&copy; <span class="current-year">2024</span> <a href="https://www.memberminderpro.com" target="_blank">Member Minder Pro, LLC</a>. All rights reserved.</p>
        </footer>
    </cfoutput>
    
    </body>
    </html>
     <!-- Forcefully output any errors caught for this page -->
        <cfcatch type="any">
            <!-- Output the error message -->
            <cfdump var="#cfcatch#" label="Error Details">
        </cfcatch>
    </cftry>