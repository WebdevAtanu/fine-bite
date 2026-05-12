"use client"

import React, { useState } from 'react'
import { CustomInput } from '@/components/re-usable/custom-input'

function CityInsert() {
  const [stateName, setStateName] = useState("");

  return (
    <div>
      <CustomInput
        label="Name"
        id="name"
        type='text'
        placeholder="Kolkata"
        value={stateName}
        setValue={setStateName}
        description='Enter city name'
      />
    </div>
  )
}

export default CityInsert