using EpistemicNetworkAnalysis
using CSV
using DataFrames

data = DataFrame(CSV.File("C:\\Users\\jscianna\\Documents\\GitHub\\ICQE-Rotations-Workshop-2024\\Data\\CodedPilot.csv"))

data[!,:HandedND] = string.(data.Handedness," ", data.ND)

codes = [:Retry, :Challenge, :ResourceUse, :Break, :GoodMove, :SeekingFeedback, :LevelComplete]
conversations = [:Username, :SessionNum]
units = [:Username,:CurrLevel]
rotation = MulticlassRotation(:HandedND)

model = ENAModel(
    data, codes, conversations, units,
    windowSize=10,
    rotateBy=rotation,
    dropEmpty=true,
)

show(model)
p = plot(model)

using Plots 
savefig(p,"MClassRotation.png")

#Saving the point positions to CSV
using CSV
CSV.write("MClassPoints.csv",model.points)