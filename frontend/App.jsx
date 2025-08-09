import React from 'react';
import './App.css';
import Chat from './components/Chat';
import FileExplorer from './components/FileExplorer';
import CodeEditor from './components/CodeEditor';

function App() {
  const [selectedFile, setSelectedFile] = React.useState(null);
  const [fileContent, setFileContent] = React.useState('');

  return (
    <div className="app-container">
      <aside className="sidebar">
        <FileExplorer onSelectFile={setSelectedFile} />
      </aside>
      <main className="main-content">
        <Chat onFileCreate={setSelectedFile} />
        <CodeEditor file={selectedFile} content={fileContent} setContent={setFileContent} />
      </main>
    </div>
  );
}

export default App;
