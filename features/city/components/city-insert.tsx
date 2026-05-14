"use client"

import React, { useState } from 'react'
import { CustomInput } from '@/components/re-usable/custom-input'
import CustomSelect from '@/components/re-usable/custom-select';

function CityInsert() {
  const [stateName, setStateName] = useState("");
  const [country, setCountry] = useState("");
  const dummy_data = ['India', 'USA', 'UK', 'Germany', 'France'];
  return (
    <div>
      <CustomInput
        label="Name"
        id="name"
        type='text'
        placeholder="London"
        value={stateName}
        setValue={setStateName}
      />
      
      <CustomSelect
        label='Country'
        data={dummy_data}
        placeholder='Select country'
        value={country}
        setValue={setCountry}
      />
    </div>
  )
}

export default CityInsert;