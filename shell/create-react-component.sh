#!/bin/sh
​
green='\033[0;32m'
magenta='\033[0;35m'
​
alias Reset="tput sgr0"
​
cecho() {
  echo "${2}${1}"
  Reset # Reset to normal.
  return
}
​
CONTINUE=false
​
cecho "What do you want to name your component?" $green
read component
echo ""
cecho "What directory should $component live? (relative to src/)" $green
read directory
echo ""
​
mkdir -p src/$directory/$component
cd src/$directory/$component
​
# Make PasCal case dasherized for sass
dasherizedcomponent=$(echo $component \
     | sed 's/\(.\)\([A-Z]\)/\1-\2/g' \
     | tr '[:upper:]' '[:lower:]')
​
# Creating Sass File
echo "@import '/styles/scss/variables';
// Make $component Excellent!
.$dasherizedcomponent {
  // Block thing for .$dasherizedcomponent
  &-element {
    // Element things for .$dasherizedcomponent
  }
}" >> index.scss;
​
# Creating React Component
echo "import React, { useState } from 'react';
import './index.scss';
​
const $component = ({ text }) => {
  const [count, setCount] = useState(0);
​
  return (
    <div className='$dasherizedcomponent'>
      {text}
    </div>
  )
}

export default $component;" >> index.js;
​
# Creating File For Testing
echo "import React from 'react';
import { fireEvent, render, wait } from '@testing-library/react';
import $component from './index';
​
const setup = (customProps ={}) => {
  const defaultProps = {};
  const props = { ...defaultProps, ...customProps};
  return render(<$component {...props}/>);
};
​
beforeEach(() => {
  jest.resetAllMocks();
});
​
describe('$component', () => {
​
  it('should render the text $component in the document', () => {
    const { getByText } = setup({ text: '$component' });
    expect(getByText('$component')).toBeInTheDocument();
  });
​
});" >> index.test.js;

# Creating File For Storybook
echo "import React from 'react';
import { action } from '@storybook/addon-actions';
import 'styles/main.scss';
import $component from './index';

export default {
  title: '$component',
  component: $component,
};

export const Regular$component = () => (
  <$component text='$component' />
);" >> index.stories.js
​
cecho "===================================" $magenta
echo  ""
cecho "Successfully created $component!" $magenta
echo  ""