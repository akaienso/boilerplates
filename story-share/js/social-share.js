// Target the generated content from the CMS
const sections = document.querySelectorAll("section.article-body");

sections.forEach((section) => {
  // Use the innerHTML of each section for transformation
  const htmlString = section.innerHTML;

  // Creating a temporary doc to work with
  const parser = new DOMParser();
  const doc = parser.parseFromString(htmlString, "text/html");

  //Setting the first opening and last closing p tags
  const divs = doc.querySelectorAll("div");
  divs.forEach((div) => {
    const p = document.createElement("p");
    p.innerHTML = div.innerHTML; // Invite everyone inside the div to the p party
    div.parentNode.replaceChild(p, div); // Smooth transition
  });

  let spans = doc.querySelectorAll("span");
  while (spans.length > 0) {
    spans.forEach((span) => {
      // Replace each span with just its inner vibe, no extra frills
      span.outerHTML = span.innerHTML;
    });
    // Check if there are still any spans left to clear out
    spans = doc.querySelectorAll("span");
  }

  // Replacing double <br> tags with closing and opening <p> tags
  const cleanedHtml = doc.body.innerHTML.replace(/<br>\s*<br>/g, "</p><p>");

  // Removing all other tags that are not <p> tags
  const finalHTML = cleanedHtml.replace(/<[^\/>][^>]*><\/[^>]+>/g, "");

  // Update the section with the cleaned up HTML
  section.innerHTML = finalHTML;
});

// Show the current year in the footer
document.querySelectorAll(".current-year").forEach(function (element) {
  const startYear = parseInt(element.textContent, 10);
  const currentYear = new Date().getFullYear();
  if (currentYear > startYear) {
    element.textContent += ` \u2013 ${currentYear}`;
  }
  // If currentYear is equal to startYear or the script fails to run, the original text remains unchanged.
});
