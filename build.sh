#!/bin/bash
dotnet --info
echo STARTED dotnet build
cd StratisBitcoinFullNode/src
dotnet build -c Release ${path} -v m

echo STARTED dotnet test

ANYFAILURES=false
for testProject in *.Tests; do

# only run integration and nbitcoin tests
#if [[ "$testProject" != *"Integration.Tests"* ]] && [[ "$testProject" != *"IntegrationTests"* ]] && [[ "$testProject" != *"NBitcoin.Tests"* ]] ; then
if [[ "$testProject" != *"Integration.Tests"* ]] ; then
    continue
fi

echo "Processing $testProject file.."; 
cd $testProject
COMMAND="dotnet test --no-build -c Release -v m"
$COMMAND
EXITCODE=$?
echo exit code for $testProject: $EXITCODE

if [ $EXITCODE -ne 0 ] ; then
    ANYFAILURES=true
fi

cd ..
done

echo FINISHED dotnet test
if [[ $ANYFAILURES == "true" ]] ; then
    exit 1
fi
