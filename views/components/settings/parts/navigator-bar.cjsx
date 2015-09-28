{$, $$, _, React, ReactBootstrap, FontAwesome, ROOT} = window
{config} = window
{Button, ButtonGroup, Input, OverlayTrigger, Tooltip} = ReactBootstrap
{__, __n} = require 'i18n'
webview = $('kan-game webview')
getIcon = (status) ->
  switch status
    when -2
      <FontAwesome name='times' />
    when -1
      <FontAwesome name='arrow-right' />
    when 0
      <FontAwesome name='check' />
    when 1
      <FontAwesome name='spinner' spin />
NavigatorBar = React.createClass
  getInitialState: ->
    # Status
    # -1: Waiting
    # 0: Finish
    # 1: Loading
    navigateStatus: 1
    navigateUrl: config.get 'poi.homepage', 'http://www.dmm.com/netgame/social/application/-/detail/=/app_id=854854/'
  handleSetUrl: (e) ->
    @setState
      navigateUrl: e.target.value
      navigateStatus: -1
  handleStartLoading: (e) ->
    @setState
      navigateStatus: 1
  handleStopLoading: ->
    @setState
      navigateStatus: 0
      navigateUrl: webview.getUrl()
  handleFailLoad: ->
    @setState
      navigateStatus: -2
  handleNavigate: ->
    if @state.navigateUrl.substr(0,7).toLowerCase()!='http://'
      if @state.navigateUrl.substr(0,8).toLowerCase()!='https://'
        @state.navigateUrl = "http://#{@state.navigateUrl}"
    webview.src = @state.navigateUrl
  handleRefresh: ->
    webview.reload()
  handleSetHomepage: ->
    config.set 'poi.homepage', @state.navigateUrl
  componentDidMount: ->
    webview.addEventListener 'did-start-loading', @handleStartLoading
    webview.addEventListener 'did-stop-loading', @handleStopLoading
    webview.addEventListener 'did-fail-load', @handleFailLoad
  componentWillUmount: ->
    webview.removeEventListener 'did-start-loading', @handleStartLoading
    webview.removeEventListener 'did-stop-loading', @handleStopLoading
    webview.removeEventListener 'did-fail-load', @handleFailLoad
  render: ->
    <div style={display: 'flex'}>
      <div style={flex: 1, marginLeft: 15, marginRight: 15}>
        <Input type='text' bsSize='small' placeholder='输入网页地址' value={@state.navigateUrl} onChange={@handleSetUrl} />
      </div>
      <div style={flex: 'none', width: 110}>
        <ButtonGroup>
          <Button bsSize='small' bsStyle='primary' onClick={@handleNavigate}>{getIcon(@state.navigateStatus)}</Button>
          <Button bsSize='small' bsStyle='warning' onClick={@handleRefresh}><FontAwesome name='refresh' /></Button>
        </ButtonGroup>
        <ButtonGroup style={marginLeft: 5}>
          <OverlayTrigger placement='top' overlay={<Tooltip>{__ 'Set as homepage'}</Tooltip>}>
            <Button bsSize='small' onClick={@handleSetHomepage}><FontAwesome name='bookmark' /></Button>
          </OverlayTrigger>
        </ButtonGroup>
      </div>
    </div>
module.exports = NavigatorBar
