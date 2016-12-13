assert = require 'assert'
fs = require 'fs-extra'
path = require 'path-extra'
CSON = require 'cson'
require('babel-register')(require('../babel.config'))

# Environments
global.ROOT = global.EXROOT = __dirname
config = null

describe 'config with saved file', ->
  beforeEach ->
    fs.writeFileSync path.join(__dirname, 'config.cson'), CSON.stringify
      path:
        to:
          initial:
            value: "Hello World"
    # Require config uncachedly
    delete require.cache[require.resolve '../lib/config']
    config = require '../lib/config'
  # Initial empty
  describe 'initially', ->
    it 'should be a initial object', ->
      assert.deepEqual config.get(''),
        path:
          to:
            initial:
              value: 'Hello World'
      assert.deepEqual config.get('path.to.initial.value'), 'Hello World'
  # Setter and Getter
  describe '#set() #get()', ->
    it 'should be set and get a string correctly', ->
      config.set 'path.to.value', 'Dead Beef'
      assert.deepEqual config.get('path.to.value'), 'Dead Beef'
    it 'should be set and get a object correctly', ->
      config.set 'another', {a: "b", c: 0xbb}
      assert.deepEqual config.get('another'), {a: "b", c: 0xbb}
    it 'should be get a null', ->
      assert.deepEqual config.get('null.path'), null
  afterEach ->
    fs.unlinkSync path.join(__dirname, 'config.cson')
