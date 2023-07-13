import os
import subprocess
from mido import Message, MidiFile, MidiTrack
from pydub import AudioSegment

# Define a list of instrument names according to the General MIDI standard
instrument_names = [
    "Acoustic Grand Piano", "Bright Acoustic Piano", "Electric Grand Piano", "Honky-tonk Piano",
    "Electric Piano 1", "Electric Piano 2", "Harpsichord", "Clavi", "Celesta", "Glockenspiel",
    "Music Box", "Vibraphone", "Marimba", "Xylophone", "Tubular Bells", "Dulcimer", "Drawbar Organ",
    "Percussive Organ", "Rock Organ", "Church Organ", "Reed Organ", "Accordion", "Harmonica",
    "Tango Accordion", "Acoustic Guitar (nylon)", "Acoustic Guitar (steel)", "Electric Guitar (jazz)",
    "Electric Guitar (clean)", "Electric Guitar (muted)", "Overdriven Guitar", "Distortion Guitar",
    "Guitar Harmonics", "Acoustic Bass", "Electric Bass (finger)", "Electric Bass (pick)", "Fretless Bass",
    "Slap Bass 1", "Slap Bass 2", "Synth Bass 1", "Synth Bass 2", "Violin", "Viola", "Cello", "Contrabass",
    "Tremolo Strings", "Pizzicato Strings", "Orchestral Harp", "Timpani", "String Ensemble 1",
    "String Ensemble 2", "Synth Strings 1", "Synth Strings 2", "Choir Aahs", "Voice Oohs", "Synth Voice",
    "Orchestra Hit", "Trumpet", "Trombone", "Tuba", "Muted Trumpet", "French Horn", "Brass Section",
    "Synth Brass 1", "Synth Brass 2", "Soprano Sax", "Alto Sax", "Tenor Sax", "Baritone Sax", "Oboe",
    "English Horn", "Bassoon", "Clarinet", "Piccolo", "Flute", "Recorder", "Pan Flute", "Blown Bottle",
    "Shakuhachi", "Whistle", "Ocarina", "Lead 1 (square)", "Lead 2 (sawtooth)", "Lead 3 (calliope)",
    "Lead 4 (chiff)", "Lead 5 (charang)", "Lead 6 (voice)", "Lead 7 (fifths)", "Lead 8 (bass + lead)",
    "Pad 1 (new age)", "Pad 2 (warm)", "Pad 3 (polysynth)", "Pad 4 (choir)", "Pad 5 (bowed)",
    "Pad 6 (metallic)", "Pad 7 (halo)", "Pad 8 (sweep)", "FX 1 (rain)", "FX 2 (soundtrack)",
    "FX 3 (crystal)", "FX 4 (atmosphere)", "FX 5 (brightness)", "FX 6 (goblins)", "FX 7 (echoes)",
    "FX 8 (sci-fi)", "Sitar", "Banjo", "Shamisen", "Koto", "Kalimba", "Bagpipe", "Fiddle", "Shanai",
    "Tinkle Bell", "Agogo", "Steel Drums", "Woodblock", "Taiko Drum", "Melodic Tom", "Synth Drum",
    "Reverse Cymbal", "Guitar Fret Noise", "Breath Noise", "Seashore", "Bird Tweet", "Telephone Ring",
    "Helicopter", "Applause", "Gunshot"
]

# Define a function to get the name of an instrument from its program number
def get_instrument_name(program):
    if 0 <= program < len(instrument_names):
        return instrument_names[program]
    else:
        return "Unknown"

def get_note_name(pitch):
    # Define a list of note names
    note_names = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    # Calculate the octave number and note name
    octave = (pitch // 12) - 1
    note_name = note_names[pitch % 12]
    # Return the note name and octave as a string
    return f'{note_name}{octave}'


def generate_sounds(note_length, instrument_program):
    # Define the directory to save the files
    output_dir = 'Sound_generator/sounds'
    os.makedirs(output_dir, exist_ok=True)

    # Calculate the time for the note_off message in MIDI ticks
    # (Assuming a tempo of 120 beats per minute and 960 ticks per beat)
    note_off_time = int(note_length * 120 * 960)

    # Create a new MIDI file
    midi = MidiFile()

    # Create a new track in the MIDI file
    track = MidiTrack()
    midi.tracks.append(track)

    # Send a program change message to set the instrument
    track.append(Message('program_change', program=instrument_program, time=0))

    # Add notes to the track for each note in 3 octaves (C4 to B6)
    for pitch in range(60, 85):
        # Note on
        track.append(Message('note_on', note=pitch, velocity=64, time=0))
        # Note off after the specified note length
        track.append(Message('note_off', note=pitch, velocity=64, time=note_off_time))

        # Save the MIDI file
        midi_filename = os.path.join(output_dir, f'note_{pitch}.mid')
        midi.save(midi_filename)

        # Use FluidSynth to convert the MIDI file to a WAV file
        wav_filename = os.path.join(output_dir, f'{get_instrument_name(instrument_program)}_{get_note_name(pitch)}.wav')
        subprocess.run(['fluidsynth', '-ni', 'GeneralUser_GS.sf2', midi_filename, '-F', wav_filename, '-r', '44100'])

        # Use pydub to convert the WAV file to an MP3 file
        os.makedirs(os.path.join(output_dir, get_instrument_name(instrument_program)), exist_ok=True)
        mp3_filename = os.path.join(output_dir, f'{get_instrument_name(instrument_program)}/note_{get_note_name(pitch)}.mp3')
        AudioSegment.from_wav(wav_filename).export(mp3_filename, format='mp3')

        # Delete the MIDI and WAV files
        os.remove(midi_filename)
        os.remove(wav_filename)

# Call the function with a note length of 0.5 seconds and the MIDI program number for Acoustic Grand Piano
generate_sounds(0.5, 0)
