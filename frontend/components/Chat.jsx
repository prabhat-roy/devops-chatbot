
import React, { useState, useRef } from 'react';

function Chat({ onFileCreate }) {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const messagesEndRef = useRef(null);

  const streamBotResponse = async (prompt) => {
    setIsLoading(true);
    setMessages(msgs => [...msgs, { sender: 'user', text: prompt }]);
    setMessages(msgs => [...msgs, { sender: 'bot', text: '' }]);
    try {
      const res = await fetch('/api/generate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ prompt })
      });
      if (!res.body || !window.ReadableStream) {
        // fallback to normal json
        const data = await res.json();
        setMessages(msgs => {
          const newMsgs = [...msgs];
          newMsgs[newMsgs.length - 1].text = data.response || JSON.stringify(data);
          return newMsgs;
        });
        setIsLoading(false);
        return;
      }
      const reader = res.body.getReader();
      let decoder = new TextDecoder();
      let fullText = '';
      let done = false;
      while (!done) {
        const { value, done: doneReading } = await reader.read();
        done = doneReading;
        if (value) {
          const chunk = decoder.decode(value);
          for (let char of chunk) {
            fullText += char;
            setMessages(msgs => {
              const newMsgs = [...msgs];
              newMsgs[newMsgs.length - 1].text = fullText;
              return newMsgs;
            });
          }
        }
      }
    } catch (e) {
      setMessages(msgs => {
        const newMsgs = [...msgs];
        newMsgs[newMsgs.length - 1].text = 'Error: Could not get response.';
        return newMsgs;
      });
    }
    setIsLoading(false);
  };

  const sendMessage = () => {
    if (!input.trim()) return;
    streamBotResponse(input);
    setInput('');
  };

  React.useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  return (
    <div className="chat">
      <div className="messages">
        {messages.map((msg, i) => (
          <div key={i} className={msg.sender}>{msg.text}</div>
        ))}
        <div ref={messagesEndRef} />
      </div>
      <div className="chat-input-row">
        <textarea
          className="chat-input"
          value={input}
          onChange={e => setInput(e.target.value)}
          onKeyDown={e => {
            if (e.key === 'Enter' && !e.shiftKey) {
              e.preventDefault();
              sendMessage();
            }
          }}
          placeholder="Type your message..."
          rows={3}
          disabled={isLoading}
        />
        <button className="send-btn" onClick={sendMessage} disabled={isLoading}>Send</button>
      </div>
      {isLoading && <div style={{marginTop: 8, color: '#007acc'}}>Bot is typing...</div>}
    </div>
  );
}

export default Chat;
