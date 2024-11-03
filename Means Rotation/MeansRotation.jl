using EpistemicNetworkAnalysis
using CSV
using DataFrames

data = DataFrame(CSV.File("C:\\Users\\jscianna\\Documents\\GitHub\\ICQE-Rotations-Workshop-2024\\Data\\CodedPilot.csv"))

codes = [:Retry, :Challenge, :ResourceUse, :Break, :GoodMove, :SeekingFeedback, :LevelComplete]
conversations = [:Username, :SessionNum]
units = [:ND, :Username,:CurrLevel]
rotation = MeansRotation(:ND, "Yes", "No")

model = ENAModel(
    data, codes, conversations, units,
    windowSize=10,
    rotateBy=rotation,
    dropEmpty=true,
)

show(model)
p = plot(model)

using Plots 
savefig(p,"MeansRotation.png")

#Saving the point positions to CSV
using CSV
CSV.write("MR_Points.csv",model.points)