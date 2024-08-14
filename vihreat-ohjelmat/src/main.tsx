import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './components/App';
import './index.css';
import { PrimeReactProvider } from 'primereact/api';
import { Store, StoreContext } from '@tomic/react';
import 'primereact/resources/themes/saga-green/theme.css';

const my_host = window.location.hostname;
const store = new Store({
  serverUrl: 'http://' + my_host + ':9883',
});

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <PrimeReactProvider>
      <StoreContext.Provider value={store}>
        <App />
      </StoreContext.Provider>
    </PrimeReactProvider>
  </React.StrictMode>,
);
