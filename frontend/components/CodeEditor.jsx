import React from 'react';
// Monaco Editor placeholder
function CodeEditor({ file, content, setContent }) {
  return (
    <div className="code-editor">
      <div>{file ? `Editing: ${file}` : 'No file selected'}</div>
      <textarea value={content} onChange={e => setContent(e.target.value)} rows={10} cols={60} />
    </div>
  );
}

export default CodeEditor;
