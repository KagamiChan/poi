import {combineReducers} from 'redux'
import reduceReducers from 'reduce-reducers'

import {reducer as basic} from './basic'
import {reducer as ships} from './ships'
import {reducer as fleets} from './fleets'
import {reducer as equips} from './equips'
import {reducer as repairs} from './repairs'
import {reducer as constructions} from './constructions'
import {reducer as resources} from './resources'
import {reducer as maps} from './maps'

export const reducer = combineReducers({
  basic,
  ships,
  fleets,
  equips,
  repairs,
  constructions,
  resources,
  maps,
})

