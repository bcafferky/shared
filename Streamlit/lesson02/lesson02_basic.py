import streamlit as st
import random

st.title('Welcome to Number Guess')
st.write('### where you guess a number ')

num = random.randrange(1, 10)

txt_guess = int(st.text_input('Enter a number between 1 and 10: ', 1))

btn_start = st.button('Start Again')

btn_guess = st.button('Make Guess')

if btn_guess:
    if txt_guess == num:
        st.write('You Win')
        st.balloons()
    else:
        st.write('Sorry. Wrong number. Try again.')

btn_show = st.button('Show Number')

if btn_show:
    st.write('The number is ', num)

with st.expander("Help..."):
    st.write('''
    Press Start and a random number between 1 and 10 will be generated.
    Try to guess the number by entering your guess in the text box and
    clicking "Make Guess"
    ''')