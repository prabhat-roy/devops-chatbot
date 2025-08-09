import React from 'react';

function FileExplorer({ onSelectFile }) {
  // Placeholder: implement file tree logic
  return (
    <div className="file-explorer">
      <div onClick={() => onSelectFile('example.py')}>example.py</div>
    </div>
  );
}

export default FileExplorer;
