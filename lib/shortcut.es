import { globalShortcut } from 'electron'
import config from './config'
import Window from './window'
import dbg from './debug'

const registerShortcut = (acc, desc, func) => {
  dbg.log(`Registering shortcut: ${acc}\t=> ${desc}`)
  try {
    globalShortcut.register(acc, func)
    return true
  } catch (err){
    console.error(`Failed to register shortcut[${acc}]: ${err}`)
    return false
  }
}

const registerBossKey = () => {
  const accelerator = config.get('poi.shortcut.bosskey', '')
  if (accelerator)
    if (!registerShortcut(accelerator, 'Boss Key', Window.toggleAllWindowsVisibility))
      config.set('poi.shortcut.bosskey', '')
}
const registerDevToolShortcut = () => {
  const accelerator = 'Ctrl+Shift+I'
  registerShortcut(accelerator, 'Open Focused Window Dev Tools', Window.openFocusedWindowDevTools)
}

export default {
  register: () => {
    if (process.platform !== 'darwin') {
      registerBossKey()
    }
    registerDevToolShortcut()
  },
  unregister: () => {
    globalShortcut.unregisterAll()
  },
}
