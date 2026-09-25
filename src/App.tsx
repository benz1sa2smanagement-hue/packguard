import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { AppProvider } from './hooks/useAppStore'
import { ToastProvider } from './hooks/useToast'
import { Layout } from './components/Layout'
import { Dashboard } from './pages/Dashboard'
import { Packing } from './pages/Packing'
import { Orders } from './pages/Orders'
import { Evidence } from './pages/Evidence'
import { Errors } from './pages/Errors'
import { History } from './pages/History'
import { Analytics } from './pages/Analytics'
import { Users } from './pages/Users'
import { Devices } from './pages/Devices'
import { Settings } from './pages/Settings'

export default function App() {
  return (
    <AppProvider>
      <ToastProvider>
        <BrowserRouter>
          <Routes>
            <Route element={<Layout />}>
              <Route index element={<Dashboard />} />
              <Route path="packing" element={<Packing />} />
              <Route path="orders" element={<Orders />} />
              <Route path="evidence" element={<Evidence />} />
              <Route path="errors" element={<Errors />} />
              <Route path="history" element={<History />} />
              <Route path="analytics" element={<Analytics />} />
              <Route path="users" element={<Users />} />
              <Route path="devices" element={<Devices />} />
              <Route path="settings" element={<Settings />} />
            </Route>
          </Routes>
        </BrowserRouter>
      </ToastProvider>
    </AppProvider>
  )
}
