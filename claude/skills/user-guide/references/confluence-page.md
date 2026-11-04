# Confluence help page

## Where

Space `<RELEASE_NOTES_SPACE>` (pass the numeric space id `<SPACE_ID>` as `spaceId`; the key "<RELEASE_NOTES_SPACE>" is only an alias and the create call rejects it), folder "<team> help", folder id `<FOLDER_ID>`.
Use a connected Confluence integration with access to the configured space.
(https://<ATLASSIAN_SITE>.atlassian.net/wiki/spaces/<RELEASE_NOTES_SPACE>/folder/<FOLDER_ID>/<help-folder>).
Pass the folder id as `parentId` to `createConfluencePage`. If the call rejects a folder as parent, ask the user for a page under that folder to nest under.

## Body

Same text as the artifact, in storage format or markdown as the tool accepts (check `getContentFormatGuide` once per session). Structure:

- Title: the feature name as the reader knows it, e.g. "Organizer e-mails in Admin panel". No ticket key in the title.
- Lede paragraph, then one heading per step (`## 1. Switch on ...`), the path line, the sentences, the image, the "what if" as a short paragraph.
- "Good to know" as a bulleted list at the end.
- Content only: no banners, no author line, no collection date, no ticket keys, no "work in progress" note (rule in `Process/Writing Style.md`, "Public spaces carry content only").

## Images

The MCP tools create and update pages but do not upload attachments. Two ways in, decided with the user before the page is created:

1. User attaches by hand. Create the page with a visible placeholder line per image (`[Image: 01-settings-tab.png]`) and hand over the PNG folder path. They drag the files onto the page in the editor.
2. API token. The user stores an Atlassian API token outside the vault (e.g. `~/.config/atlassian/token`, never in a `.md`). Upload with the REST API, one call per file, then update the page body with `<ac:image><ri:attachment ri:filename="01-settings-tab.png"/></ac:image>`:

```
curl -s -u "<email>:$(cat ~/.config/atlassian/token)" \
  -H "X-Atlassian-Token: nocheck" \
  -F "file=@01-settings-tab.png" \
  "https://<ATLASSIAN_SITE>.atlassian.net/wiki/rest/api/content/<pageId>/child/attachment"
```

Until one of the two happens the page carries placeholders, and the chat reply says so.
