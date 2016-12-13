import path from 'path-extra'
import React from 'react'
import { Tabs, Tab } from 'react-bootstrap'
import FontAwesome from 'react-fontawesome'
import { PoiConfig, DisplayConfig, NetworkConfig, PluginConfig, Others } from './parts'

const {i18n} = window
const __ = i18n.setting.__.bind(i18n.setting)

export default {
  name: 'SettingsView',
  priority: 10001,
  displayName: <span><FontAwesome name='cog' />{__(" Settings")}</span>,
  description: '功能设置界面',
  reactClass: class reactClass extends React.Component {
    shouldComponentUpdate = (nextProps, nextState) => (false)
    render() {
      return (
        <Tabs bsStyle="pills" defaultActiveKey={0} animation={false} justified id="settings-view-tabs">
          <link rel="stylesheet" href={path.join(__dirname, 'assets', 'settings.css')} />
          <Tab eventKey={0} title={__("Common")} className='poi-settings-Tab'>
            <PoiConfig />
          </Tab>
          <Tab eventKey={1} title={__("Display")} className='poi-settings-Tab'>
            <DisplayConfig />
          </Tab>
          <Tab eventKey={2} title={__("Proxy")} className='poi-settings-Tab'>
            <NetworkConfig />
          </Tab>
          <Tab eventKey={3} title={__("Plugins")} className='poi-settings-Tab'>
            <PluginConfig />
          </Tab>
          <Tab eventKey={-1} title={__("About")} className='poi-settings-Tab'>
            <Others />
          </Tab>
        </Tabs>
      )
    }
  },
}
