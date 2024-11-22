
backend return code (c# .ashx for example) :
`context.Response.BinaryWrite((MemoryStream)excelFile.ToArray())`

javascript:
```javascript
const ExportData = async () => {
    const exportUrl = '';
    const response = await fetch(exportUrl, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        }
    });
    // Check if the response is okay
    if (!response.ok) {
        throw new Error('Network response was not ok');
    }
    const blob = await response.blob(); // Get the response as a blob
    // Create a temporary URL for the blob
    const url = window.URL.createObjectURL(blob);
    const linkElement = document.createElement('a');
    linkElement.href = url;
    linkElement.download = `filename.xlsx`; // Specify the filename
    document.body.appendChild(linkElement);
    linkElement.click(); // Simulate click to trigger download
    document.body.removeChild(linkElement); // Clean up
    // Revoke the object URL after download
    window.URL.revokeObjectURL(url);
}

```
