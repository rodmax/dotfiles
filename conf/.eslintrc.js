/*
 * Copyright (C) 2016 Synesis LLC. All rights reserved.
 * Author Maxim Rodionov <max.rodionov@synesis.ru>, Synesis LLC www.synesis.ru.
 */
/*
 * Eslint config file
 * Configuration guide http://eslint.org/docs/user-guide/configuring
 * Rules list http://eslint.org/docs/rules/
**/
const OFF = 0;
const WARN = 1;
const ERR = 2;

module.exports = {
    root: true,  // prevent search .eslintrc in parent dirs
    extends: 'eslint:recommended',
    parserOptions: {
        ecmaVersion: 6,
        sourceType: 'module',  // your code is in ECMAScript modules
    },
    env: {
        es6: true,
        commonjs: true,
        node: true,
    },
    rules: {
        indent: ['error', 4, {SwitchCase: 1}],
        'linebreak-style': [ERR, 'unix'],
        'eol-last': [ERR],
        'no-trailing-spaces': [ERR],
        'no-mixed-spaces-and-tabs': [ERR],
        'no-multiple-empty-lines': [ERR, {max: 2, maxBOF: 0, maxEOF: 1}],
        'max-len': [ERR, 120, 4],
        camelcase: [ERR],
        'no-console': [OFF],  // allow for dev scripts
        'new-cap': [ERR, {
            newIsCap: true,
            capIsNew: true,
            capIsNewExceptions: [
                '$.Deferred',
                // jasmine-given
                'Given',
                'When',
                'Then',
                'And'
            ]}],
        'new-parens': [ERR],
        'one-var': [ERR, 'never'],
        'object-curly-spacing': [ERR, 'never'],
        'array-bracket-spacing': [ERR, 'never'],
        'key-spacing': [ERR],
        quotes: [ERR, 'single'],
        semi: [ERR, 'always'],
        'no-extra-semi': [ERR],
        'semi-spacing': [ERR],
        'comma-style': [ERR, 'last'],
        'no-spaced-func': [ERR],
        'space-before-function-paren': [ERR, {anonymous: 'always', named: 'never'}],
        'keyword-spacing': [ERR, {before: true, after: true}],
        'space-in-parens': [ERR, 'never'],
        'no-multi-spaces': [ERR],
        'operator-linebreak': [ERR, 'after'],
        curly: [ERR],
        'brace-style': [ERR],
        'space-before-blocks': [ERR, 'always'],
        'no-cond-assign': [ERR],
        yoda: [ERR, 'never'],
        'no-duplicate-case': [ERR],
        'no-inner-declarations': [ERR, 'both'],
        'no-unreachable': [ERR],
        'no-redeclare': [ERR, {builtinGlobals: true}],
        'no-with': [ERR],
        eqeqeq: [ERR],
        'no-unneeded-ternary': [ERR],
        'space-unary-ops': [ERR, {words: true, nonwords: false}],
        'no-eval': [ERR],
        'no-throw-literal': [ERR],
        'valid-typeof': [ERR],
        'no-implicit-coercion': [ERR, {boolean: true, number: true, string: true}],
        'no-multi-str': [ERR],
        'spaced-comment': [ERR, 'always'],

        'array-callback-return': [ERR],
        'block-scoped-var': [ERR],
        complexity: [WARN, 20],
        'newline-per-chained-call': [ERR, {ignoreChainWithDepth: 3}],
        'no-lonely-if': [ERR],
        'arrow-parens': [ERR, 'as-needed'],
        'arrow-spacing': [ERR],
        'no-confusing-arrow': [ERR],
        'no-duplicate-imports': [ERR],
        'no-useless-computed-key': [ERR],
        'template-curly-spacing': [ERR],
        'no-shadow': [ERR, {builtinGlobals: true, hoist: 'functions', allow: [
            'require',
            'root',  // It is exactly the same as global, root is deprecated since Node.js v6
        ]}],
        'quote-props': [ERR, 'as-needed']
    }
};
